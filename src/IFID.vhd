LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IFID IS 
PORT(
    instIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	addressIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk: IN STD_LOGIC; -- clock.
	IFIDWrite: IN STD_LOGIC;
    instOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	addressOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END IFID;

ARCHITECTURE description OF IFID IS

BEGIN
    process(clk)
    begin
        if clk='1' and clk'event then 
			if IFIDWrite = '1' then 
				instOut <= instIn;
				addressOut <= addressIn;
			end if;
        end if;
    end process;
END description;