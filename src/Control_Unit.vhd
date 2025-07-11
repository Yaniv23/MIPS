-- ============================================================================
--  Control_Unit.vhd
--  Description:
--      Main control unit for MIPS processor.
--      Decodes opcode and generates control signals for datapath.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    port (
        opcode    : in  STD_LOGIC_VECTOR(5 downto 0); -- Instruction [31-26]
        RegDst    : out STD_LOGIC;                    -- Register destination select
        Jump      : out STD_LOGIC;                    -- Jump signal
        Branch    : out STD_LOGIC;                    -- Branch signal
        MemRead   : out STD_LOGIC;                    -- Memory read enable
        MemtoReg  : out STD_LOGIC;                    -- Memory to register select
        ALUOp     : out STD_LOGIC_VECTOR(1 downto 0); -- ALU operation code
        MemWrite  : out STD_LOGIC;                    -- Memory write enable
        ALUSrc    : out STD_LOGIC;                    -- ALU source select
        RegWrite  : out STD_LOGIC                     -- Register write enable
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
begin
    process(opcode)
    begin
        RegWrite <= '0'; -- Default value
        case opcode is
            when "000000" =>  -- R-type: And, Or, Add, Sub, Slt
                RegDst     <= '1';
                ALUSrc     <= '0';
                MemtoReg   <= '0';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '0';
                ALUOp      <= "10";
                Jump       <= '0';
                RegWrite   <= '1';

            when "100011" =>  -- lw (load word)
                RegDst     <= '0';
                ALUSrc     <= '1';
                MemtoReg   <= '1';
                MemRead    <= '1';
                MemWrite   <= '0';
                Branch     <= '0';
                ALUOp      <= "00";
                Jump       <= '0';
                RegWrite   <= '1';

            when "101011" =>  -- sw (store word)
                RegDst     <= '0';
                ALUSrc     <= '1';
                MemtoReg   <= '0';
                RegWrite   <= '0';
                MemRead    <= '0';
                MemWrite   <= '1';
                Branch     <= '0';
                ALUOp      <= "00";
                Jump       <= '0';

            when "000100" =>  -- beq (branch equal)
                RegDst     <= '0';
                ALUSrc     <= '0';
                MemtoReg   <= '0';
                RegWrite   <= '0';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '1';
                ALUOp      <= "01";
                Jump       <= '0';

            when "000101" =>  -- bne (branch not equal)
                RegDst     <= '0';
                ALUSrc     <= '0';
                MemtoReg   <= '0';
                RegWrite   <= '0';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '1';
                ALUOp      <= "01"; -- ALU will subtract for comparison
                Jump       <= '0';

            when "000010" =>  -- j (jump)
                RegDst     <= '0';
                ALUSrc     <= '0';
                MemtoReg   <= '0';
                RegWrite   <= '0';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '0';
                ALUOp      <= "00";
                Jump       <= '1';

            when "001000" =>  -- addi (add immediate)
                RegDst     <= '0';
                ALUSrc     <= '1';
                MemtoReg   <= '0';
                RegWrite   <= '1';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '0';
                ALUOp      <= "00";
                Jump       <= '0';

            when others =>     -- Default case
                RegDst     <= '0';
                ALUSrc     <= '0';
                MemtoReg   <= '0';
                RegWrite   <= '0';
                MemRead    <= '0';
                MemWrite   <= '0';
                Branch     <= '0';
                ALUOp      <= "00";
                Jump       <= '0';
        end case;
    end process;
end Behavioral;
