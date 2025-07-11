library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;  -- for console output
use IEEE.STD_LOGIC_TEXTIO.ALL;

library work;
use work.MIPS_Constants.ALL;

entity TB_Data_Memory is
end TB_Data_Memory;

architecture behavior of TB_Data_Memory is

    -- Component Declaration
    component Data_Memory
        Port (
            Address     : in std_logic_vector(31 downto 0);
            WriteData  : in std_logic_vector(31 downto 0);
            MemWrite   : in std_logic;
            MemRead    : in std_logic;
            ReadData   : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals
    signal Address     : std_logic_vector(31 downto 0);
    signal WriteData  : std_logic_vector(31 downto 0);
    signal MemWrite   : std_logic := '0';
    signal MemRead    : std_logic := '0';
    signal ReadData   : std_logic_vector(31 downto 0);

    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    constant BASE_ADDR  : integer := DATA_BASE_ADDRESS;

begin

    -- Instantiate UUT
    uut: Data_Memory
        port map (
            Address     => Address,
            WriteData  => WriteData,
            MemWrite   => MemWrite,
            MemRead    => MemRead,
            ReadData   => ReadData
        );

    -- Stimulus process
    stim_proc: process
        variable L : line;
    begin
        -- Write to BASE_ADDR
        Address    <= std_logic_vector(to_unsigned(BASE_ADDR, 32));
        WriteData <= x"DEADBEEF";
        MemWrite  <= '1';
        MemRead   <= '0';
        wait for CLK_PERIOD;

        MemWrite  <= '0';
        wait for CLK_PERIOD;

        -- Read from BASE_ADDR
        MemRead <= '1';
        wait for CLK_PERIOD;

        

        MemRead <= '0';
        wait for CLK_PERIOD;

        -- Read from BASE_ADDR + 4 (uninitialized)
        Address <= std_logic_vector(to_unsigned(BASE_ADDR + 4, 32));
        MemRead <= '1';
        wait for CLK_PERIOD;
        
        -- Write to BASE_ADDR + 4 
        MemRead <= '0';
        MemWrite <= '1' ;
        WriteData <= x"12345678" ; 
        wait for CLK_PERIOD;
        -- Read from BASE_ADDR + 4 
        MemRead <= '1';
        MemWrite <= '0' ;
        wait;
    end process;

end behavior;
