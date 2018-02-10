library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity DataMemory is	
Port ( MemRead,MemWrite:in std_logic;
Address : in std_logic_vector(31 downto 0); -- write address to store the data into ram
WriteData : in std_logic_vector(31 downto 0); -- input data to store into ram	
ReadData : out std_logic_vector(31 downto 0)); -- output data from memory	
end DataMemory;	
architecture Behavioral of DataMemory is	
------------------------------------- RAM declaration 
type ram is array(128 -1 downto 0) of std_logic_vector(7 downto 0);	
signal ram1_1 : ram;	
-------------------------------------- Signal declaration 


begin	

process(MemRead,MemWrite,Address,WriteData)	
variable first: boolean:= true;
variable j : integer;
begin	

if(first) then
	 ram1_1(0) <= "00000000";
	 ram1_1(1) <= "00000000";	
	 ram1_1(2) <= "00000000";
	 ram1_1(3) <= "00000100";
	
	 ram1_1(4) <= "00000000";
	 ram1_1(5) <= "00000000";	
	 ram1_1(6) <= "00000000";
	 ram1_1(7) <= "00000100";

	
	first:= false;
end if;

j := conv_integer(unsigned(Address));
if MemWrite = '1' then -- In this process writing the input data into ram 
	ram1_1(j) <= WriteData(31 downto 24);
	ram1_1(j+1) <= WriteData(23 downto 16);	
	ram1_1(j+2) <= WriteData(15 downto 8);
	ram1_1(j+3) <= WriteData(7 downto 0);
end if;	

if MemRead = '1' then
	ReadData (31 downto 24)<= ram1_1(j); -- Reading the data from RAM 
	ReadData(23 downto 16) <= ram1_1(j+1);
	ReadData(15 downto 8) <= ram1_1(j+2);
	ReadData(7 downto 0) <= ram1_1(j+3);
end if;

end process;	



end Behavioral;