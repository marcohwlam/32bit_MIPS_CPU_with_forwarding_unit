library ieee;
use IEEE.std_logic_1164.all;

entity ThreeInputMUX32 is
port(x,y,z:in std_logic_vector (31 downto 0);
     sel:in std_logic_vector(1 downto 0);
     w:out std_logic_vector(31 downto 0));
end ThreeInputMUX32;

architecture beh of ThreeInputMUX32 is 
	begin
	process(sel,x,y,z)
		begin
		if sel = "10" then
			w<=y;
		elsif sel = "01" then
			w<=z;
		else
			w<=x;
		end if;
	end process;
end beh;
