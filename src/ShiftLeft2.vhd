library ieee;
use ieee.std_logic_1164.all;

entity ShiftLeft2 is
  port(x:in std_logic_vector(31 downto 0);
       y:out std_logic_vector(31 downto 0));
end ShiftLeft2;

architecture beh of ShiftLeft2 is
begin
process(x)
variable temp : std_logic_vector(29 downto 0);
begin
  temp := x(29 downto 0);
  y(1 downto 0) <= (others => '0');
  y(31 downto 2) <= temp;
end process;
end beh;
