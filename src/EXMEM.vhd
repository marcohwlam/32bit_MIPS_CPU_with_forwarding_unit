LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXMEM IS 
PORT(
	clk: IN STD_LOGIC;
	MemReadIn,MemWriteIn,RegWriteIn,MemtoRegIn:in std_logic;
	addResultIn,ALUResultIn,RD2In: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	WRIn:in std_logic_vector(4 downto 0);   
	
    MemReadOut,MemWriteOut,RegWriteOut,MemtoRegOut:out std_logic;
	addResultOut,ALUResultOut,RD2Out: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	WROut:out std_logic_vector(4 downto 0));
END EXMEM;

ARCHITECTURE description OF EXMEM IS

BEGIN
    process(clk)
    begin
        if clk='1' and clk'event then 
			MemReadOut<=MemReadIn;
			MemWriteOut<=MemWriteIn;
			RegWriteOut<=RegWriteIn;
			MemtoRegOut<=MemtoRegIn;
			addResultOut<=addResultIn;
			ALUResultOut<=ALUResultIn;
			RD2Out<=RD2In;
			WROut<=WRIn;
        end if;
    end process;
END description;