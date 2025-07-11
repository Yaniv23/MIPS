library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_ALU_Control is
end TB_ALU_Control;

architecture behavior of TB_ALU_Control is

    -- Component Declaration
    component ALU_Control
        Port (
            Funct : in STD_LOGIC_VECTOR (5 downto 0);
            ALUOp       : in STD_LOGIC_VECTOR (1 downto 0);
            OP_out      : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals
    signal Funct : STD_LOGIC_VECTOR (5 downto 0);
    signal ALUOp       : STD_LOGIC_VECTOR (1 downto 0);
    signal OP_out      : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- Instantiate Unit Under Test (UUT)
    uut: ALU_Control
        Port map (
            Funct => Funct,
            ALUOp       => ALUOp,
            OP_out      => OP_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- LW / SW (ALUOp = "00") -> ADD
        ALUOp       <= "00";
        Funct <= "XXXXXX";  -- ignored
        wait for 10 ns;

        -- BEQ (ALUOp = "01") -> SUB
        ALUOp       <= "01";
        Funct <= "XXXXXX";  -- ignored
        wait for 10 ns;

        -- R-type ADD
        ALUOp       <= "10";
        Funct <= "100000";
        wait for 10 ns;

        -- R-type SUB
        Funct <= "100010";
        wait for 10 ns;

        -- R-type AND
        Funct <= "100100";
        wait for 10 ns;

        -- R-type OR
        Funct <= "100101";
        wait for 10 ns;

        -- R-type SLT
        Funct <= "101010";
        wait for 10 ns;

        -- Finish simulation
        wait;
    end process;

end behavior;
