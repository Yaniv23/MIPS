-- ============================================================================
--  Mux_2x1.vhd
--  Description:
--      Generic N-bit 2-to-1 multiplexer for MIPS datapath.
--      Selects between two N-bit inputs based on the select signal.
--      Outputs I1 if sel='1', otherwise outputs I0.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1 is
    generic (N : integer := 32);  -- Data width
    port (
        I0  : in  STD_LOGIC_VECTOR(N-1 downto 0);
        I1  : in  STD_LOGIC_VECTOR(N-1 downto 0); 
        sel : in  STD_LOGIC;                      
        Y   : out STD_LOGIC_VECTOR(N-1 downto 0)  
    );
end Mux_2x1;

architecture Behavioral of Mux_2x1 is
begin
    
    Y <= I1 when sel = '1' else I0;
end Behavioral;
