-- ============================================================================
--  Instruction_Memory.vhd
--  Description:
--      Read-only memory for MIPS instructions.
--      Each instruction is 32 bits, stored as 4 consecutive bytes.
--      Outputs the instruction at the given address.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.MIPS_Constants.ALL;

entity Instruction_Memory is
    generic (
        N : integer := 32      -- Instruction width
    );
    port (
        ReadAddress : in  STD_LOGIC_VECTOR(N-1 downto 0);   -- Address to read
        Instruction : out STD_LOGIC_VECTOR(N-1 downto 0)    -- Output instruction
    );
end entity Instruction_Memory;

architecture Behavioral of Instruction_Memory is
    -- Memory array: 512 bytes (128 instructions)
    type memory_array is array (0 to 511) of STD_LOGIC_VECTOR(7 downto 0);

    signal memory : memory_array := (
        -- Example program: 
        --The Goal is to Count from 0 up to 5, using slt to check if the counter is less than 5, and store the result in memory.
        x"20", x"08", x"00", x"00",  -- addi $t0, $zero, 0      ; $t0 = 0         ; counter
        x"20", x"09", x"00", x"05",  -- addi $t1, $zero, 5      ; $t1 = 5         ; limit
        x"01", x"09", x"50", x"2A",  -- slt  $t2, $t0, $t1      ; $t2 = ($t0 < $t1) ? 1 : 0
        x"11", x"40", x"00", x"02",  -- beq  $t2, $zero, end    ; if $t2 == 0, exit loop
        x"21", x"08", x"00", x"01",  -- addi $t0, $t0, 1        ; $t0 = $t0 + 1
        x"08", x"00", x"00", x"02",  -- j    loop               ;repeat loop
        x"AE", x"28", x"00", x"00",  -- sw   $t0, 0($s1)        ; store final value of $t0 at address in $s1
        others => x"00"
        -- Fill the rest with zeros

    );
begin
    process(ReadAddress)
    begin
        -- Combine 4 bytes to form a 32-bit instruction
        Instruction <= memory(to_integer(unsigned(ReadAddress))) &
                       memory(to_integer(unsigned(ReadAddress)) + 1) &
                       memory(to_integer(unsigned(ReadAddress)) + 2) &
                       memory(to_integer(unsigned(ReadAddress)) + 3);
    end process;
end architecture Behavioral;