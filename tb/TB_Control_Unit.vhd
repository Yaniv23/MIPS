------------------------------------------------------------------------
--  Simplified Testbench : tb_control_unit.vhd
--  Applies MIPS opcodes and shows outputs manually
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity TB_Control_Unit is
end entity;

architecture sim of TB_Control_Unit is

    signal opcode    : std_logic_vector(5 downto 0) := (others=>'0');

    signal RegDst    : std_logic;
    signal Jump      : std_logic;
    signal Branch    : std_logic;
    signal MemRead   : std_logic;
    signal MemtoReg  : std_logic;
    signal ALUOp     : std_logic_vector(1 downto 0);
    signal MemWrite  : std_logic;
    signal ALUSrc    : std_logic;
    signal RegWrite  : std_logic;

begin

    --------------------------------------------------------------------
    -- Instantiate the DUT
    --------------------------------------------------------------------
    DUT: entity work.Control_Unit
        port map(
            opcode    => opcode,
            RegDst    => RegDst,
            Jump      => Jump,
            Branch    => Branch,
            MemRead   => MemRead,
            MemtoReg  => MemtoReg,
            ALUOp     => ALUOp,
            MemWrite  => MemWrite,
            ALUSrc    => ALUSrc,
            RegWrite  => RegWrite
        );

    --------------------------------------------------------------------
    -- Simple stimulus process
    --------------------------------------------------------------------
    stim : process
    begin
        -- addi
        opcode <= "001000"; wait for 20 ns;
        -- addi
        opcode <= "001000"; wait for 20 ns;
        -- R-type
        opcode <= "000000"; wait for 20 ns;
        -- R-type
        opcode <= "000000"; wait for 20 ns;
        -- lw
        opcode <= "100011"; wait for 20 ns;
        -- sw
        opcode <= "101011"; wait for 20 ns;
        -- beq
        opcode <= "000100"; wait for 20 ns;
        -- j
        opcode <= "000010"; wait for 20 ns;
        -- addi
        opcode <= "001000"; wait for 20 ns;
        -- default (invalid)
        opcode <= "111111"; wait for 20 ns;

        wait;
    end process;

end architecture;
