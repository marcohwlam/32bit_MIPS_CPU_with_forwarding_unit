LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 USE ieee.std_logic_arith.all;
 use ieee.std_logic_unsigned.all;
 
entity ForwardingUnit is -- need to test two instructions before.
	port(EXMEMRegWrite: in std_logic;
		 MEMWBRegWrite: in std_logic;
		 MEMWBRegisterRd: in std_logic_vector(4 downto 0); 
		 EXMEMRegisterRd: in std_logic_vector(4 downto 0); 
		 IDEXRegisterRs: in std_logic_vector(4 downto 0);
		 IDEXRegisterRt: in std_logic_vector(4 downto 0);

		 ForwardA: out std_logic_vector(1 downto 0);
		 ForwardB: out std_logic_vector(1 downto 0));
end ForwardingUnit;	 
		 
architecture beh of ForwardingUnit is

begin
	process(EXMEMRegWrite,MEMWBRegWrite,MEMWBRegisterRd,EXMEMRegisterRd,IDEXRegisterRs,IDEXRegisterRt)
	
	begin

-- EX hazard
		if EXMEMRegWrite = '1' and EXMEMRegisterRd /= "00000" 
			and EXMEMRegisterRd = IDEXRegisterRs then
		
			ForwardA <= "10";		
		end if;
		
		if EXMEMRegWrite = '1' and EXMEMRegisterRd /= "00000" 
			and EXMEMRegisterRd = IDEXRegisterRt then
		
			ForwardB <= "10";		
		end if;

-- Mem hazard		
		if MEMWBRegWrite = '1' and MEMWBRegisterRd /= "00000" 
			and not (EXMEMRegWrite = '1' and EXMEMRegisterRd /= "00000")
			and EXMEMRegisterRd /= IDEXRegisterRs
			and MEMWBRegisterRd = IDEXRegisterRs then
			-- hazard on one instruction before
			ForwardA <= "01";
		end if;
		
		if MEMWBRegWrite = '1' and MEMWBRegisterRd /= "00000" 
			and not (EXMEMRegWrite = '1' and EXMEMRegisterRd /= "00000")
			and EXMEMRegisterRd /= IDEXRegisterRt 
			and MEMWBRegisterRd = IDEXRegisterRt then
			-- hazard on one instruction before
			ForwardB <= "01";
		end if;
		
	end process;
end beh;