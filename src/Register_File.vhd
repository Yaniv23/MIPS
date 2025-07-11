-- ============================================================================
--  Register_File.vhd
--  Description:
--      Implements a 32-register file for MIPS, each register is N bits wide.
--      Supports two asynchronous reads and one synchronous write.
--      Register 0 ($zero) is hardwired to zero.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is
    generic(
        N: integer := 32;  -- number of bits
        W: integer := 5    -- number of address bits
    );
    Port ( 
        clk               : in std_logic;
        ReadReg1, ReadReg2 : in std_logic_vector(W-1 downto 0);
        WriteReg           : in std_logic_vector(W-1 downto 0);
        RegWrite_EN        : in std_logic;                        -- Write enable signal
        Write_Data         : in std_logic_vector(N-1 downto 0);
        ReadData1, ReadData2 : out std_logic_vector(N-1 downto 0) -- Output of register read  
    );
end Register_File;

architecture Behavioral of Register_File is
    -- Array of 32 registers, each N bits wide
    type reg_file_type is array (0 to 31) of std_logic_vector(N-1 downto 0);

    signal array_reg : reg_file_type := (
        x"00000000",  -- $zero  0
        x"11111111",  -- $at    1
        x"22222222",  -- $v0    2
        x"33333333",  -- $v1    3
        x"44444444",  -- $a0    4
        x"55555555",  -- $a1    5
        x"66666666",  -- $a2    6
        x"77777777",  -- $a3    7
        x"88888888",  -- $t0    8
        x"99999999",  -- $t1    9
        x"aaaaaaaa",  -- $t2    10
        x"bbbbbbbb",  -- $t3    11
        x"cccccccc",  -- $t4    12
        x"dddddddd",  -- $t5    13
        x"eeeeeeee",  -- $t6    14
        x"ffffffff",  -- $t7    15
        x"00000000",  -- $s0    16
        x"11111111",  -- $s1    17
        x"22222222",  -- $s2    18
        x"33333333",  -- $s3    19
        x"44444444",  -- $s4    20
        x"55555555",  -- $s5    21
        x"66666666",  -- $s6    22
        x"77777777",  -- $s7    23
        x"88888888",  -- $t8    24
        x"99999999",  -- $t9    25
        x"aaaaaaaa",  -- $k0    26
        x"bbbbbbbb",  -- $k1    27
        x"10000000",  -- $gp    28
        x"7FFFFEC0",  -- $sp    29
        x"eeeeeeee",  -- $fp    30
        x"ffffffff"   -- $ra    31
    );
begin
    -- Synchronous write process
    process(clk)
    begin
        if rising_edge(clk) then
            if RegWrite_EN = '1' then
                array_reg(to_integer(unsigned(WriteReg))) <= Write_Data;
            end if;
        end if;
    end process;

    -- Asynchronous read process, $zero always returns 0
    process(ReadReg1, ReadReg2)
    begin
        if to_integer(unsigned(ReadReg1)) = 0 then
            ReadData1 <= (others => '0');
        else
            ReadData1 <= array_reg(to_integer(unsigned(ReadReg1)));
        end if;

        if to_integer(unsigned(ReadReg2)) = 0 then
            ReadData2 <= (others => '0');
        else
            ReadData2 <= array_reg(to_integer(unsigned(ReadReg2)));
        end if;
    end process;
end Behavioral;
