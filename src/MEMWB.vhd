LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MEMWB IS 
PORT(
	clk: IN STD_LOGIC;
	RegWriteIn,MemtoRegIn:in std_logic;
	dataIn,ALUResultIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	WRIn:in std_logic_vector(4 downto 0);   
	
    RegWriteOut,MemtoRegOut:out std_logic;
	dataOut,ALUResultOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	WROut:out std_logic_vector(4 downto 0));
END MEMWB;

ARCHITECTURE description OF MEMWB IS

BEGIN
    process(clk)
    begin
        if clk='1' and clk'event then 
			RegWriteOut<=RegWriteIn;
			MemtoRegOut<=MemtoRegIn;
			dataOut<=dataIn;
			ALUResultOut<=ALUResultIn;
			WROut<=WRIn;
        end if;
    end process;
END description;