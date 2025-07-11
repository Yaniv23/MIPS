library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.MIPS_Constants.ALL;

entity TB_Instruction_Memory is
end TB_Instruction_Memory;

architecture Behavioral of TB_Instruction_Memory is

    signal ReadAddress : std_logic_vector(31 downto 0) := (others => '0');
    signal Instruction : std_logic_vector(31 downto 0);

    component Instruction_Memory
        Port (
            ReadAddress  : in  STD_LOGIC_VECTOR(31 downto 0);
            Instruction  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin

    -- Instantiate the Instruction_Memory component
    UUT: Instruction_Memory
        port map (
            ReadAddress => ReadAddress,
            Instruction => Instruction
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test sequence: Read instructions word by word
        for i in 0 to 11 loop
            ReadAddress <= std_logic_vector(to_unsigned(i * 4, 32)); -- Word-aligned address
            wait for 10 ns;
        end loop;

        wait;
    end process;

end Behavioral;
