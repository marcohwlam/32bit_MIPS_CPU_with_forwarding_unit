library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2Jump is
port(x: in std_logic_vector(3 downto 0);
 y: in std_logic_vector(25 downto 0); 
z:out std_logic_vector(31 downto 0));
end ShiftLeft2Jump;

architecture beh of ShiftLeft2Jump is 
signal temp: std_logic_vector(31 downto 0);
begin

temp <= x & y & "00";
z <= temp;
end beh;