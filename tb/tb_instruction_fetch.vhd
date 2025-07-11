library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_instruction_fetch is
end entity;

architecture sim of tb_instruction_fetch is

    component Instruction_Design_wrapper
        port (
            Instruction_0  : out std_logic_vector(31 downto 0);
            rst_manual     : in  std_logic_vector(0 to 0);
            C_F_0          : out std_logic;
            OF_F_0         : out std_logic
        );
    end component;

    -- Signals for ports
    signal Instruction_0  : std_logic_vector(31 downto 0);
    signal rst_manual     : std_logic_vector(0 to 0);
    signal C_F_0          : std_logic;
    signal OF_F_0         : std_logic;

begin

    DUT: Instruction_Design_wrapper
        port map (
            Instruction_0 => Instruction_0,
            rst_manual    => rst_manual,
            C_F_0         => C_F_0,
            OF_F_0        => OF_F_0
        );

    -- Stimulus process
    process
    begin
        rst_manual <= "0";
        
        wait;
    end process;

end architecture;
