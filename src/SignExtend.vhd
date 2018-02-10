library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity SignExtend is
port(x:in std_logic_vector(15 downto 0);y:out std_logic_vector(31 downto 0));
end SignExtend;

architecture beh of SignExtend is
  signal temp : std_logic_vector(31 downto 0);
  begin

  process(x)
  begin
  temp <= std_logic_vector(resize(signed(x),temp'length));
  end process;
y <= temp;
end beh;