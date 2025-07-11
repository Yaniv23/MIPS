-- ============================================================================
--  MIPS_Constants.vhd
--  Description:
--      Package containing opcode, funct, and register constants for MIPS.
--      Used for instruction decoding and register identification.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package MIPS_Constants is

    -- R-Type Opcode (always 000000)
    constant OPCODE_RTYPE : std_logic_vector(5 downto 0) := "000000";

    -- R-Type Funct Codes
    constant FUNCT_ADD  : std_logic_vector(5 downto 0) := "100000";
    constant FUNCT_SUB  : std_logic_vector(5 downto 0) := "100010";
    constant FUNCT_AND  : std_logic_vector(5 downto 0) := "100100";
    constant FUNCT_OR   : std_logic_vector(5 downto 0) := "100101";
    constant FUNCT_SLT  : std_logic_vector(5 downto 0) := "101010";
    constant FUNCT_SLL  : std_logic_vector(5 downto 0) := "000000";
    constant FUNCT_SRL  : std_logic_vector(5 downto 0) := "000010";
    constant FUNCT_JR   : std_logic_vector(5 downto 0) := "001000";

    -- I-Type Opcodes
    constant OPCODE_LW    : std_logic_vector(5 downto 0) := "100011";
    constant OPCODE_SW    : std_logic_vector(5 downto 0) := "101011";
    constant OPCODE_BEQ   : std_logic_vector(5 downto 0) := "000100";
    constant OPCODE_BNE   : std_logic_vector(5 downto 0) := "000101";
    constant OPCODE_ADDI  : std_logic_vector(5 downto 0) := "001000";
    constant OPCODE_ANDI  : std_logic_vector(5 downto 0) := "001100";
    constant OPCODE_ORI   : std_logic_vector(5 downto 0) := "001101";
    constant OPCODE_SLTI  : std_logic_vector(5 downto 0) := "001010";
    constant OPCODE_LUI   : std_logic_vector(5 downto 0) := "001111";

    -- J-Type Opcodes
    constant OPCODE_J     : std_logic_vector(5 downto 0) := "000010";
    constant OPCODE_JAL   : std_logic_vector(5 downto 0) := "000011";

    -- Register Names (by number, based on standard MIPS convention)
    constant REG_ZERO : std_logic_vector(4 downto 0) := "00000"; -- $zero
    constant REG_AT   : std_logic_vector(4 downto 0) := "00001"; -- $at
    constant REG_V0   : std_logic_vector(4 downto 0) := "00010"; -- $v0
    constant REG_V1   : std_logic_vector(4 downto 0) := "00011"; -- $v1
    constant REG_A0   : std_logic_vector(4 downto 0) := "00100"; -- $a0
    constant REG_A1   : std_logic_vector(4 downto 0) := "00101"; -- $a1
    constant REG_A2   : std_logic_vector(4 downto 0) := "00110"; -- $a2
    constant REG_A3   : std_logic_vector(4 downto 0) := "00111"; -- $a3
    constant REG_T0   : std_logic_vector(4 downto 0) := "01000"; -- $t0
    constant REG_T1   : std_logic_vector(4 downto 0) := "01001"; -- $t1
    constant REG_T2   : std_logic_vector(4 downto 0) := "01010"; -- $t2
    constant REG_T3   : std_logic_vector(4 downto 0) := "01011"; -- $t3
    constant REG_T4   : std_logic_vector(4 downto 0) := "01100"; -- $t4
    constant REG_T5   : std_logic_vector(4 downto 0) := "01101"; -- $t5
    constant REG_T6   : std_logic_vector(4 downto 0) := "01110"; -- $t6
    constant REG_T7   : std_logic_vector(4 downto 0) := "01111"; -- $t7
    constant REG_S0   : std_logic_vector(4 downto 0) := "10000"; -- $s0
    constant REG_S1   : std_logic_vector(4 downto 0) := "10001"; -- $s1
    constant REG_S2   : std_logic_vector(4 downto 0) := "10010"; -- $s2
    constant REG_S3   : std_logic_vector(4 downto 0) := "10011"; -- $s3
    constant REG_S4   : std_logic_vector(4 downto 0) := "10100"; -- $s4
    constant REG_S5   : std_logic_vector(4 downto 0) := "10101"; -- $s5
    constant REG_S6   : std_logic_vector(4 downto 0) := "10110"; -- $s6
    constant REG_S7   : std_logic_vector(4 downto 0) := "10111"; -- $s7
    constant REG_T8   : std_logic_vector(4 downto 0) := "11000"; -- $t8
    constant REG_T9   : std_logic_vector(4 downto 0) := "11001"; -- $t9
    constant REG_K0   : std_logic_vector(4 downto 0) := "11010"; -- $k0
    constant REG_K1   : std_logic_vector(4 downto 0) := "11011"; -- $k1
    constant REG_GP   : std_logic_vector(4 downto 0) := "11100"; -- $gp
    constant REG_SP   : std_logic_vector(4 downto 0) := "11101"; -- $sp
    constant REG_FP   : std_logic_vector(4 downto 0) := "11110"; -- $fp
    constant REG_RA   : std_logic_vector(4 downto 0) := "11111"; -- $ra

    -- Others Constants
    constant DATA_BASE_ADDRESS : unsigned(31 downto 0) := x"10010000";

end MIPS_Constants;
