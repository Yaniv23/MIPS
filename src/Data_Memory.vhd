-- ============================================================================
--  Data_Memory.vhd
--  Description:
--      Implements a 1KB data memory for MIPS.
--      Supports synchronous write and combinational read.
--      Address is word-aligned (uses bits [9:2]).
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
    port (
        clk       : in  std_logic;                        
        Address   : in  std_logic_vector(31 downto 0);    
        WriteData : in  std_logic_vector(31 downto 0);    -- Data to write
        MemWrite  : in  std_logic;                        -- Write enable
        MemRead   : in  std_logic;                        -- Read enable
        ReadData  : out std_logic_vector(31 downto 0)     -- Data read
    );
end Data_Memory;

architecture Behavioral of Data_Memory is
    type memory_array is array(0 to 255) of std_logic_vector(31 downto 0); -- 256 words (1 KB)
    signal memory : memory_array := (others => (others => '0'));
    signal addr_index : integer range 0 to 255;
begin
    -- Calculate word index from byte address (ignore lowest 2 bits)
    -- Use Address(9 downto 2) for word-aligned addressing (byte address to word index)
    addr_index <= to_integer(unsigned(Address(9 downto 2)));

    -- Synchronous write process
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                memory(addr_index) <= WriteData;
            end if;
        end if;
    end process;

    -- Asynchronous read process
    process(Address, MemRead)
    begin
        if MemRead = '1' then
            ReadData <= memory(addr_index);
        else
            ReadData <= (others => '0');
        end if;
    end process;
end Behavioral;
