library ieee;
use IEEE.std_logic_1164.all;

entity MUX32 is
port(x,y:in std_logic_vector (31 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(31 downto 0));
end MUX32;

architecture beh of MUX32 is 
	begin
	process(sel,x,y)
		begin
		if sel = '1' then
			z<=y;
		else
			z<=x;
		end if;
	end process;
end beh;
