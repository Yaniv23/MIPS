-- ============================================================================
--  MIPS_ALU.vhd
--  Description:
--      Arithmetic Logic Unit for MIPS processor.
--      Supports AND, OR, ADD, SUB, SLT, NOR operations.
--      Outputs result, zero flag, overflow flag, and carry flag.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS_ALU is
    generic (N : integer := 32);  -- Data width
    port (
        A, B      : in  STD_LOGIC_VECTOR(N-1 downto 0);   -- ALU operands
        Alu_Ctrl  : in  STD_LOGIC_VECTOR(3 downto 0);     
        Alu_Rslt  : out STD_LOGIC_VECTOR(N-1 downto 0);   
        Zero_F    : out STD_LOGIC;                        
        OF_F      : out STD_LOGIC;                        -- Overflow flag
        C_F       : out STD_LOGIC                         -- Carry flag
    );
end MIPS_ALU;

architecture Behavioral of MIPS_ALU is
    signal A_s, B_s : signed(N-1 downto 0);      -- Signed versions of inputs
    signal A_u, B_u : unsigned(N-1 downto 0);    -- Unsigned versions of inputs
begin
    -- Convert inputs to signed/unsigned
    A_s <= signed(A);
    B_s <= signed(B);
    A_u <= unsigned(A);
    B_u <= unsigned(B);

    process(A_s, B_s, A_u, B_u, Alu_Ctrl)
        variable temp_result : signed(N downto 0); -- Extra bit for carry/overflow
    begin
        case Alu_Ctrl is
            when "0000" => -- AND
                temp_result := ('0' & (A_s and B_s));
                C_F <= '0';
                OF_F <= '0';

            when "0001" => -- OR
                temp_result := ('0' & (A_s or B_s));
                C_F <= '0';
                OF_F <= '0';

            when "0010" => -- ADD
                temp_result := ('0' & A_s) + ('0' & B_s);
                C_F <= temp_result(N); -- Carry out
                -- Overflow detection for addition
                OF_F <= (A_s(N-1) xor temp_result(N-1)) and not (A_s(N-1) xor B_s(N-1));

            when "0110" => -- SUB
                temp_result := ('0' & A_s) - ('0' & B_s);
                C_F <= temp_result(N); -- Carry out
                -- Overflow detection for subtraction
                OF_F <= (A_s(N-1) xor B_s(N-1)) and (A_s(N-1) xor temp_result(N-1));

            when "0111" => -- SLT (set on less than)
                if A_s < B_s then
                    temp_result := (others => '0'); temp_result(0) := '1';
                else
                    temp_result := (others => '0');
                end if;
                C_F <= '0';
                OF_F <= '0';

            when "1100" => -- NOR
                temp_result := ('0' & not (A_s or B_s));
                C_F <= '0';
                OF_F <= '0';

            when others =>
                temp_result := (others => '0');
                C_F <= '0';
                OF_F <= '0';
        end case;

        -- Assign result
        Alu_Rslt <= std_logic_vector(temp_result(N-1 downto 0));

        -- Zero flag: set if result is zero
        if temp_result(N-1 downto 0) = to_signed(0, N) then
            Zero_F <= '1';
        else
            Zero_F <= '0';
        end if;
    end process;

end Behavioral;
