LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 USE ieee.std_logic_arith.all;
 use ieee.std_logic_unsigned.all;
 
entity HazardDetectionUnit is -- need to test two instructions before.
	port(IDEXMemRead: in std_logic;
		 IDEXRegisterRt: in std_logic_vector(4 downto 0); 
		 IFIDRegisterRs: in std_logic_vector(4 downto 0);
		 IFIDRegisterRt: in std_logic_vector(4 downto 0);

		 sel: out std_logic;
		 IFIDWrite: out std_logic;
		 PCWrite: out std_logic);
end HazardDetectionUnit;	 
		 
architecture beh of HazardDetectionUnit is

begin
	process(IDEXMemRead,IDEXRegisterRt,IFIDRegisterRs,IFIDRegisterRt)
	
	begin

	--lw hazard
		if IDEXMemRead = '1' and 
		(IDEXRegisterRt = IFIDRegisterRs or IDEXRegisterRt = IFIDRegisterRt) then
			IFIDWrite<='0';
			PCWrite<='0';
			sel<='0';
		else 
			IFIDWrite<='1';
			PCWrite<='1';
			sel<='1';
		
		end if;
		
	end process;
end beh;