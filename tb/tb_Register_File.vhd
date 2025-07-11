library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Register_File is
end tb_Register_File;

architecture Behavioral of tb_Register_File is

    constant N : integer := 32;
    constant W : integer := 5;

    signal ReadReg1    : std_logic_vector(W-1 downto 0);
    signal ReadReg2    : std_logic_vector(W-1 downto 0);
    signal WriteReg    : std_logic_vector(W-1 downto 0);
    signal RegWrite_EN : std_logic;
    signal Write_Data  : std_logic_vector(N-1 downto 0);
    signal ReadData1   : std_logic_vector(N-1 downto 0);
    signal ReadData2   : std_logic_vector(N-1 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.Register_File
        generic map (
            N => N,
            W => W
        )
        port map (
            ReadReg1     => ReadReg1,
            ReadReg2     => ReadReg2,
            WriteReg     => WriteReg,
            RegWrite_EN  => RegWrite_EN,
            Write_Data   => Write_Data,
            ReadData1    => ReadData1,
            ReadData2    => ReadData2
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        RegWrite_EN <= '0';
        WriteReg    <= (others => '0');
        Write_Data  <= (others => '0');
        ReadReg1    <= "00001"; -- Read $at
        ReadReg2    <= "00010"; -- Read $v0
        wait for 10 ns;

        -- Write to register $t0 (address 8)
        WriteReg    <= "01000";  -- $t0
        Write_Data  <= x"DEADBEEF";
        RegWrite_EN <= '1';
        wait for 10 ns;
        RegWrite_EN <= '0';

        -- Read back from $t0 and $at
        ReadReg1 <= "01000"; -- Read $t0
        ReadReg2 <= "00001"; -- Read $at
        wait for 10 ns;

        -- Write to register $s1 (address 17)
        WriteReg    <= "10001"; -- $s1
        Write_Data  <= x"CAFEBABE";
        RegWrite_EN <= '1';
        wait for 10 ns;
        RegWrite_EN <= '0';

        -- Read back from $s1
        ReadReg1 <= "10001"; -- Read $s1
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
