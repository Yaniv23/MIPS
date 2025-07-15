# MIPS Processor Project

A complete MIPS processor implementation in VHDL using Xilinx Vivado. This project demonstrates a fully functional 32-bit MIPS processor with support for R-type, I-type, and J-type instructions.

## 🚀 Features

- **Complete MIPS Architecture**: Full 32-bit MIPS processor implementation
- **Instruction Support**: R-type, I-type, and J-type instructions
- **Core Components**:
  - 32-bit ALU with arithmetic and logical operations
  - Register file with 32 registers
  - Control unit with instruction decoding
  - Data and instruction memory
  - Program counter (PC)
  - Barrel shifter for shift operations
  - Sign extender for immediate values
- **Comprehensive Testing**: Individual testbenches for each component
- **Block Design**: Vivado block design for visual processor architecture
- **Assembly Support**: Sample assembly programs and assembler

## 📁 Project Structure

```
MIPS/
├── src/                           # VHDL source files
│   ├── ALU_Control.vhd           # ALU control unit
│   ├── BarrelShift.vhd           # Barrel shifter for shift operations
│   ├── Control_Unit.vhd          # Main control unit
│   ├── Data_Memory.vhd           # Data memory module
│   ├── Instruction_Memory.vhd    # Instruction memory module
│   ├── MIPS_ALU.vhd              # 32-bit ALU implementation
│   ├── MIPS_Constants.vhd        # MIPS opcode and register constants
│   ├── Mux_2x1.vhd               # 2-to-1 multiplexer
│   ├── Mux_Nx1.vhd               # N-to-1 multiplexer
│   ├── PC.vhd                    # Program counter
│   ├── Register_File.vhd         # 32-register file
│   └── Sign_Extender.vhd         # Sign extension unit
├── tb/                           # Testbenches
│   ├── TB_ALU_Control.vhd        # ALU control testbench
│   ├── TB_Control_Unit.vhd       # Control unit testbench
│   ├── TB_Data_Memory.vhd        # Data memory testbench
│   ├── tb_instruction_fetch.vhd  # Instruction fetch testbench
│   ├── TB_Instruction_Memory.vhd # Instruction memory testbench
│   └── tb_Register_File.vhd      # Register file testbench
├── bd/                           # Block design files
│   └── Instruction_Design/       # Vivado block design
│       ├── Instruction_Design.bd # Main block design
│       └── ip/                   # Generated IP cores
├── firmware/                     # Assembly programs
│   ├── program.asm               # Sample assembly program
│   ├── program.hex.vhd           # Hex representation for memory
│   └── mini_mips_asm_labels.py   # Assembly label processor
├── scripts/                      # Automation scripts
│   └── create_project.tcl        # Vivado project creation script
├── LICENSE                       # MIT License
└── README.md                     # This file
```

## 🛠️ Supported Instructions

### R-Type Instructions
- `ADD`, `SUB` - Addition and subtraction
- `AND`, `OR` - Bitwise logical operations
- `SLT` - Set less than
- `SLL`, `SRL` - Shift left/right logical
- `JR` - Jump register

### I-Type Instructions
- `LW`, `SW` - Load/store word
- `BEQ`, `BNE` - Branch if equal/not equal
- `ADDI` - Add immediate
- `ANDI`, `ORI` - Bitwise logical immediate
- `SLTI` - Set less than immediate
- `LUI` - Load upper immediate

### J-Type Instructions
- `J` - Jump
- `JAL` - Jump and link

## 🚀 Getting Started

### Prerequisites
- Xilinx Vivado (2020.1 or later recommended)
- Windows/Linux system with sufficient resources

### Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd MIPS
   ```

2. **Option 1: Use the automated script**
   ```bash
   cd scripts
   vivado -mode tcl -source create_project.tcl
   ```

3. **Option 2: Manual setup**
   - Open Xilinx Vivado
   - Create a new project targeting `xc7a35tcpg236-1` (or your preferred FPGA)
   - Add all VHDL files from the `src/` directory
   - Add testbench files from the `tb/` directory
   - Import the block design from `bd/Instruction_Design/`

### Running Simulations

1. **Individual Component Testing**
   - Set any testbench file as the top module
   - Run behavioral simulation
   - Verify component functionality

2. **Full Processor Testing**
   - Use the block design as the top module
   - Load the sample program from `firmware/program.asm`
   - Run simulation to see processor execution

### Sample Program

The included sample program demonstrates a simple counting loop:

```assembly
addi $t0, $zero, 0      ; Initialize counter to 0
addi $t1, $zero, 5      ; Set limit to 5
loop:
    slt  $t2, $t0, $t1  ; Check if counter < limit
    beq  $t2, $zero, end ; Exit if counter >= limit
    addi $t0, $t0, 1    ; Increment counter
    j    loop           ; Repeat loop
end:
    sw   $t0, 0($s1)    ; Store final counter value
```

## 🧪 Testing

Each major component includes comprehensive testbenches:

- **ALU Control**: Tests instruction decoding and ALU operation selection
- **Control Unit**: Verifies control signal generation for different instruction types
- **Data Memory**: Tests memory read/write operations
- **Instruction Memory**: Validates instruction fetch functionality
- **Register File**: Tests register read/write operations

Run simulations to verify component functionality before integration.

## 🏗️ Architecture Overview

The processor follows a classic MIPS single-cycle architecture:

1. **Instruction Fetch**: PC points to instruction memory
2. **Instruction Decode**: Control unit decodes opcode and generates control signals
3. **Execute**: ALU performs operations based on instruction type
4. **Memory Access**: Load/store instructions access data memory
5. **Write Back**: Results written back to register file

## 📊 Resource Utilization

Typical resource usage on Xilinx 7-series FPGAs:
- LUTs: ~1,500
- Flip-Flops: ~800
- Block RAM: 2 blocks (for instruction and data memory)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add appropriate testbenches
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- MIPS instruction set architecture reference
- Xilinx Vivado documentation
- Computer architecture principles from Patterson & Hennessy

## 📚 Further Reading

- [MIPS Instruction Set Reference](https://www.mips.com/products/architectures/mips32-2/)
- [Xilinx Vivado User Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2020_1/ug994-vivado-ip-subsystems.pdf)
- Computer Organization and Design: The Hardware/Software Interface
- VHDL
- Vivado Block Design

## License

This project is licensed under the MIT License - see the LICENSE file for details.
