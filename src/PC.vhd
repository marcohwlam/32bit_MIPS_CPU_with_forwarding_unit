library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
port(clk:in std_logic;
	 PCWrite: in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end PC;

architecture beh of PC is
begin
process(clk)
variable temp: std_logic_vector(31 downto 0);
variable runFlag: boolean:=false;
begin
  if clk = '1' and clk' event then 
	if runFlag=true then
		temp := AddressIn;
	else
		temp:="00000000000000000000000000000000";
		runFlag:=True;
	end if;
  end if; 
  if PCWrite = '1' then
	AddressOut <= temp;
  end if;
end process;
end beh;
