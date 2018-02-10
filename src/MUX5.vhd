library ieee;
use IEEE.std_logic_1164.all;

entity MUX5 is
port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
end MUX5;

architecture beh of MUX5 is 
	begin
	process(sel,x,y)
		begin
		if sel = '0' then
			z<=x;
		else
			z<=y;
		end if;
	end process;
end beh;
