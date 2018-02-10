library ieee;
use ieee.std_logic_1164.all;
entity ZeroGenerator is
port(x,y : in std_logic_vector(31 downto 0);
	 zero : out std_logic);
end ZeroGenerator;

architecture beh of ZeroGenerator is
begin
process(x,y)
variable i : integer;
variable w : std_logic;
begin
  i := 0;
  w := '0';
  while i < 32 and w = '0' loop
    w := x(i) xor y(i);
    i := i + 1;
  end loop;
  if i = 32 then
	zero <= '1';
  else
	zero <= '0';
  end if;

end process;
end beh;