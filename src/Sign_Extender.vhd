-- ============================================================================
--  Sign_Extender.vhd
--  Description:
--      This component extends a 16-bit signed input to a 32-bit signed output.
--      If the input is negative (MSB=1), the upper 16 bits are filled with '1'.
--      Otherwise, the upper 16 bits are filled with '0'.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sign_Extender is
    port (
        in_16  : in  STD_LOGIC_VECTOR(15 downto 0);   
        out_32 : out STD_LOGIC_VECTOR(31 downto 0)    
    );
end Sign_Extender;

architecture Behavioral of Sign_Extender is
begin
    
    out_32 <= x"0000" & in_16 when in_16(15) = '0' else
              x"FFFF" & in_16;
end Behavioral;
