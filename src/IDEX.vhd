LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IDEX IS 
PORT(
	clk: IN STD_LOGIC;
	RegDstIn,ALUSrcIn,BranchIn,MemReadIn,MemWriteIn,JumpIn,RegWriteIn,MemtoRegIn,ZeroIn:in std_logic;
    ALUOpIn:in std_logic_vector(1 downto 0);
	addressIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	RD1In,RD2In,signExIn:in std_logic_vector(31 downto 0);
	jumpAddIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	rsIn,rtIn,tdIn:in std_logic_vector(4 downto 0);   
	
    RegDstOut,ALUSrcOut,BranchOut,MemReadOut,MemWriteOut,JumpOut,RegWriteOut,MemtoRegOut,ZeroOut:out std_logic;
    ALUOpOut:out std_logic_vector(1 downto 0);
	addressOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	RD1Out,RD2Out,signExOut:out std_logic_vector(31 downto 0);
	jumpAddOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	rsOut,rtOut,tdOut:out std_logic_vector(4 downto 0));
END IDEX;

ARCHITECTURE description OF IDEX IS

BEGIN
    process(clk)
    begin
        if clk='1' and clk'event then 
            RegDstOut<=RegDstIn;
			ALUSrcOut<=ALUSrcIn;
			BranchOut<=BranchIn;
			MemReadOut<=MemReadIn;
			MemWriteOut<=MemWriteIn;
			JumpOut<=JumpIn;
			RegWriteOut<=RegWriteIn;
			MemtoRegOut<=MemtoRegIn;
			ZeroOut<=ZeroIn;
			ALUOpOut<=ALUOpIn;
			addressOut<=addressIn;
			RD1Out<=RD1In;
			RD2Out<=RD2In;
			signExOut<=signExIn;
			jumpAddOut<=jumpAddIn;
			rsOut<=rsIn;
			rtOut<=rtIn;
			tdOut<=tdIn;
        end if;
    end process;
END description;