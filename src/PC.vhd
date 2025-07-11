-- ============================================================================
--  PC.vhd
--  Description:
--      Program Counter (PC) for MIPS processor.
--      Holds the address of the current instruction.
--      Supports synchronous update and asynchronous reset.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    generic (N : integer := 32);  -- Address width
    port (
        clk          : in  STD_LOGIC;                        
        rst          : in  STD_LOGIC;                        
        Next_Address : in  STD_LOGIC_VECTOR(N-1 downto 0);  
        PC_out       : out STD_LOGIC_VECTOR(N-1 downto 0)    
    );
end PC;

architecture Behavioral of PC is
    signal PC_reg : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); -- PC register
begin
    process(clk, rst)
    begin
        if rst = '1' then
            PC_reg <= (others => '0');        -- Reset PC to 0
        elsif rising_edge(clk) then
            PC_reg <= Next_Address;           -- Update PC on clock edge
        end if;
    end process;

    PC_out <= PC_reg;                         -- Output current PC value
end Behavioral;
