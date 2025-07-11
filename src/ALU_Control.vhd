-- ============================================================================
--  ALU_Control.vhd
--  Description:
--      This component generates the ALU operation control signal (OP_out)
--      for a MIPS processor, based on the ALUOp signal from the Control Unit
--      and the Funct field from the instruction (for R-type instructions).
--      It outputs a 4-bit code that selects the operation to be performed by
--      the ALU (e.g., add, subtract, AND, OR, set-on-less-than).
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Control is
    port (
        Funct  : in  STD_LOGIC_VECTOR(5 downto 0);  
        ALUOp  : in  STD_LOGIC_VECTOR(1 downto 0);  
        OP_out : out STD_LOGIC_VECTOR(3 downto 0)   
    );
end ALU_Control;

architecture Behavioral of ALU_Control is
begin
    process(Funct, ALUOp)
    begin
        
        if (ALUOp = "00" or (ALUOp = "10" and Funct = "100000")) then
            OP_out <= x"2"; -- ADD operation
        elsif (ALUOp = "01" or (ALUOp = "10" and Funct = "100010")) then
            OP_out <= x"6"; -- SUBTRACT operation
        elsif (ALUOp = "10") then
            -- R-type: decode Funct field
            if (Funct = "100100") then
                OP_out <= x"0"; -- AND operation
            elsif (Funct = "100101") then
                OP_out <= x"1"; -- OR operation
            elsif (Funct = "101010") then
                OP_out <= x"7"; -- SET-ON-LESS-THAN operation
            end if;
        end if;
    end process;
end Behavioral;
