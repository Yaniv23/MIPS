#!/usr/bin/env python3
import re
from typing import List, Tuple

REG = {
    **{f"${i}": i for i in range(32)},
    "$zero": 0, "$at": 1, "$v0": 2, "$v1": 3,
    "$a0": 4, "$a1": 5, "$a2": 6, "$a3": 7,
    "$t0": 8, "$t1": 9, "$t2": 10, "$t3": 11,
    "$t4": 12, "$t5": 13, "$t6": 14, "$t7": 15,
    "$s0": 16, "$s1": 17, "$s2": 18, "$s3": 19,
    "$s4": 20, "$s5": 21, "$s6": 22, "$s7": 23,
    "$t8": 24, "$t9": 25, "$k0": 26, "$k1": 27,
    "$gp": 28, "$sp": 29, "$fp": 30, "$ra": 31,
}

OPCODE = {
    "addi": 0x08, "lw": 0x23, "sw": 0x2B,
    "beq": 0x04, "bne": 0x05, "j": 0x02
}

FUNCT = {
    "add": 0x20, "sub": 0x22, "and": 0x24,
    "or":  0x25, "slt": 0x2A
}

def imm16(val: int) -> int:
    return val & 0xFFFF

def parse_reg(tok: str) -> int:
    if tok not in REG:
        raise ValueError(f"Unknown register {tok}")
    return REG[tok]

def fmt_bytes(word: int) -> str:
    return ", ".join(f'x\"{(word >> sh) & 0xFF:02X}\"' for sh in (24, 16, 8, 0))

class Assembler:
    def __init__(self, lines: List[str]):
        self.lines = lines
        self.labels = {}
        self.result = []

    def pass1_collect_labels(self):
        pc = 0
        for raw in self.lines:
            text = raw.strip().split('#')[0]
            if not text: continue
            if ":" in text:
                label = text.replace(":", "").strip()
                if label in self.labels:
                    raise ValueError(f"Duplicate label: {label}")
                self.labels[label] = pc
            elif text:
                pc += 1

    def parse_line(self, text: str, pc: int) -> Tuple[int, str]:
        text = text.strip().split('#')[0]
        if not text or text.endswith(":"):
            return None

        # R-type
        m = re.match(r"(\w+)\s+\$(\w+),\s*\$(\w+),\s*\$(\w+)", text, re.I)
        if m and m.group(1).lower() in FUNCT:
            name, rd, rs, rt = m.groups()
            word = (0 << 26) | (parse_reg(f"${rs}") << 21) | (parse_reg(f"${rt}") << 16) | (parse_reg(f"${rd}") << 11) | (0 << 6) | FUNCT[name.lower()]
            return word, text

        # addi
        m = re.match(r"addi\s+\$(\w+),\s*\$(\w+),\s*(-?\w+)", text, re.I)
        if m:
            rt, rs, imm = m.groups()
            word = (OPCODE["addi"] << 26) | (parse_reg(f"${rs}") << 21) | (parse_reg(f"${rt}") << 16) | imm16(int(imm, 0))
            return word, text

        # lw/sw
        m = re.match(r"(lw|sw)\s+\$(\w+),\s*(-?\w+)\(\$(\w+)\)", text, re.I)
        if m:
            op, rt, off, rs = m.groups()
            word = (OPCODE[op.lower()] << 26) | (parse_reg(f"${rs}") << 21) | (parse_reg(f"${rt}") << 16) | imm16(int(off, 0))
            return word, text

        # beq/bne
        m = re.match(r"(beq|bne)\s+\$(\w+),\s*\$(\w+),\s*(\w+)", text, re.I)
        if m:
            op, rs, rt, label = m.groups()
            if label not in self.labels:
                raise ValueError(f"Unknown label: {label}")
            offset = self.labels[label] - (pc + 1)
            if not -32768 <= offset <= 32767:
                raise ValueError(f"Offset out of range for {op} at PC {pc}")
            word = (OPCODE[op] << 26) | (parse_reg(f"${rs}") << 21) | (parse_reg(f"${rt}") << 16) | imm16(offset)
            return word, text

        # j
        m = re.match(r"j\s+(\w+)", text, re.I)
        if m:
            label = m.group(1)
            if label not in self.labels:
                raise ValueError(f"Unknown label: {label}")
            addr = self.labels[label]
            word = (OPCODE["j"] << 26) | (addr & 0x03FFFFFF)
            return word, text

        raise ValueError(f"Unsupported or malformed line: {text}")

    def pass2_encode(self):
        pc = 0
        for ln, raw in enumerate(self.lines, 1):
            text = raw.strip().split('#')[0]
            if not text or text.endswith(":"): continue
            try:
                res = self.parse_line(text, pc)
                if res:
                    word, asm = res
                    self.result.append(f"{fmt_bytes(word)},  -- {asm}")
                    pc += 1
                # Ensure label lines do not increment PC
            except Exception as e:
                print(f"[Line {ln}] {e}")

    def assemble(self):
        self.pass1_collect_labels()
        self.pass2_encode()
        return self.result

# Run from command line
if __name__ == "__main__":
    import sys, pathlib
    if len(sys.argv) != 2:
        print("Usage: python mini_mips_asm_labels.py file.asm")
        sys.exit(1)

    with open(sys.argv[1]) as f:
        lines = f.readlines()

    asm = Assembler(lines)
    out_lines = asm.assemble()

    out_file = pathlib.Path(sys.argv[1]).with_suffix(".hex.vhd")
    out_file.write_text("\n".join(out_lines) + "\nothers => x\"00\"\n")
    print(f"✔ Written {len(out_lines)} instructions to {out_file}")
    print("\nPreview:\n" + "\n".join(out_lines))

