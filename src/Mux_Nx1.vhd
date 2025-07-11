library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_2x1 is
    generic(N:=integer:4);
    Port ( Data_in : in STD_LOGIC_VECTOR (0 downto 0);
           Sel : in STD_LOGIC_VECTOR (0 downto 0);
           Data_out : in STD_LOGIC_VECTOR (0 downto 0));
end Mux_2x1;

architecture Behavioral of Mux_2x1 is

begin


end Behavioral;
