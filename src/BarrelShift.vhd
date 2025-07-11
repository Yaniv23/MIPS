-- ============================================================================
--  BarrelShift.vhd
--  Description:
--      Generic barrel shifter for MIPS.
--      Shifts input data left or right by a fixed amount (W).
--      Direction is set by generic parameter 'dir'.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BarrelShift is
    generic (
        N         : positive := 8;            -- Input width
        W         : natural  := 1;            -- Shift amount 
        OUT_WIDTH : positive := 8;            -- Output width
        dir       : std_logic := '0'          -- '0' = SHL, '1' = SHR
    );
    port (
        data_in  : in  STD_LOGIC_VECTOR(N-1 downto 0);         -- Input data
        data_out : out STD_LOGIC_VECTOR(OUT_WIDTH-1 downto 0)  -- Shifted output
    );
end entity BarrelShift;

architecture Comb of BarrelShift is
    signal shifted : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    process(data_in)
    begin
        if dir = '0' then  -- SHIFT LEFT
            shifted <= data_in(N-W-1 downto 0) & (W-1 downto 0 => '0');
        else               -- SHIFT RIGHT
            shifted <= (W-1 downto 0 => '0') & data_in(N-1 downto W);
        end if;
    end process;

    -- Truncate or extend shifted result to match OUT_WIDTH
    data_out <= shifted(OUT_WIDTH-1 downto 0) when OUT_WIDTH <= N else
                shifted & (OUT_WIDTH-N-1 downto 0 => '0');
end architecture Comb;
