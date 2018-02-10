library ieee;
use ieee.std_logic_1164.all; use ieee.std_logic_arith.all;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);  
     ReadData:out std_logic_vector(31 downto 0));
end InstMemory;

architecture beh of InstMemory is
type memoryArray is array(0 to 255) of std_logic_vector(7 downto 0);
signal sel: std_logic_vector(2 downto 0) := "011";
--signal memContents:memoryArray;
begin
process(Address)
variable i: integer;
variable first: boolean:= true;
variable memContents:memoryArray;
begin
if(first) then

case sel is
when "000" =>
-- code 1

-- add $s3,$s4,$s5
  memcontents(0):="00000010";
  memcontents(1):="10010101";
  memcontents(2):="10011000";
  memcontents(3):="00100000";
-- lw $s0,0($t0)
  memcontents(4):="10001101";
  memcontents(5):="00010000";
  memcontents(6):="00000000";
  memcontents(7):="00000000";
-- lw $s1,4($t0)
  memcontents(8):="10001101";
  memcontents(9):="00010001";
  memcontents(10):="00000000";
  memcontents(11):="00000100";
-- sub $s7,$s4,$s6
  memcontents(12):="00000010";
  memcontents(13):="10010110";
  memcontents(14):="10111000";
  memcontents(15):="00100010";
-- sw $s3,8($t0)
  memcontents(16):="10101101";
  memcontents(17):="00010011";
  memcontents(18):="00000000";
  memcontents(19):="00001000";
 
 ------------------------------------------
 when "001" =>
-- code 2

-- add $s3,$s4,$s5 
  memcontents(0):="00000010";
  memcontents(1):="10010101";
  memcontents(2):="10011000";
  memcontents(3):="00100000";
-- lw $s0,0($t0)
  memcontents(4):="10001101";
  memcontents(5):="00010000";
  memcontents(6):="00000000";
  memcontents(7):="00000000";
-- lw $s1,4($t0)
  memcontents(8):="10001101";
  memcontents(9):="00010001";
  memcontents(10):="00000000";
  memcontents(11):="00000100";
-- sub $s7,$s4,$s6
  memcontents(12):="00000010";
  memcontents(13):="10010110";
  memcontents(14):="10111000";
  memcontents(15):="00100010";
-- sw $s7,8($t0)
  memcontents(16):="10101101";
  memcontents(17):="00010111";
  memcontents(18):="00000000";
  memcontents(19):="00001000";
 
 --------------------------------------------
 when "010" =>
 -- code 3
 
-- add $s3,$s4,$s5
  memcontents(0):="00000010";
  memcontents(1):="10010101";
  memcontents(2):="10011000";
  memcontents(3):="00100000";
-- lw $s0,0($t0)
  memcontents(4):="10001101";
  memcontents(5):="00010000";
  memcontents(6):="00000000";
  memcontents(7):="00000000";
-- lw $s1,4($t0)
  memcontents(8):="10001101";
  memcontents(9):="00010001";
  memcontents(10):="00000000";
  memcontents(11):="00000100";
-- sub $s7,$s4,$s6
  memcontents(12):="00000010";
  memcontents(13):="10010110";
  memcontents(14):="10111000";
  memcontents(15):="00100010";
-- nop
  memcontents(16):="00000000";
  memcontents(17):="00000000";
  memcontents(18):="00000000";
  memcontents(19):="00000000";
-- nop
  memcontents(20):="00000000";
  memcontents(21):="00000000";
  memcontents(22):="00000000";
  memcontents(23):="00000000";
-- sw $s7,8($t0)
  memcontents(24):="10101101";
  memcontents(25):="00010111";
  memcontents(26):="00000000";
  memcontents(27):="00001000";
  
--------------------------------------------
when "011"=>
--code 4

-- beq $t1,$t2,L
  memcontents(0):="00010001";
  memcontents(1):="00101010";
  memcontents(2):="00000000";
  memcontents(3):="00000100";
-- nop
  memcontents(4):="00000000";
  memcontents(5):="00000000";
  memcontents(6):="00000000";
  memcontents(7):="00000000";   
-- nop 
  memcontents(8):="00000000";
  memcontents(9):="00000000";
  memcontents(10):="00000000";
  memcontents(11):="00000000";       
-- add $t3,$s4,$s5
  memcontents(12):="00000010";
  memcontents(13):="10010101";
  memcontents(14):="01011000";
  memcontents(15):="00100000";
-- j exit
  memcontents(16):="00001000";
  memcontents(17):="00000000";
  memcontents(18):="00000000";
  memcontents(19):="00001000";
-- L sub $t4,$s4,$s5
  memcontents(20):="00000010";
  memcontents(21):="10010101";
  memcontents(22):="01100000";
  memcontents(23):="00100010";
-- add $t5,$s4,$s4
  memcontents(24):="00000010";
  memcontents(25):="10010100";
  memcontents(26):="01101000";
  memcontents(27):="00100000";

--------------------------------------------
when "100"=>
--code 5

-- beq $t1,$t2,L
  memcontents(0):="00010001";
  memcontents(1):="00101010";
  memcontents(2):="00000000";
  memcontents(3):="00000011";
-- nop
  memcontents(4):="00000000";
  memcontents(5):="00000000";
  memcontents(6):="00000000";
  memcontents(7):="00000000"; 
-- add $t3,$s4,$s5
  memcontents(8):="00000010";
  memcontents(9):="10010101";
  memcontents(10):="01011000";
  memcontents(11):="00100000";
-- j exit
  memcontents(12):="00001000";
  memcontents(13):="00000000";
  memcontents(14):="00000000";
  memcontents(15):="00000110"; 
-- L sub $t4,$s4,$s5
  memcontents(16):="00000010";
  memcontents(17):="10010101";
  memcontents(18):="01100000";
  memcontents(19):="00100010";
-- add $t5,$s4,$s4
  memcontents(20):="00000010";
  memcontents(21):="10010100";
  memcontents(22):="01101000";
  memcontents(23):="00100000";
 
when others =>
  report "unreachable" severity failure;
 
end case;

first:= false;
end if;
i := conv_integer(unsigned(Address));
-- Read Data byte by byte 

ReadData(31 downto 24) <= memContents(i); --(7 downto 0);
ReadData(23 downto 16) <= memContents(i+1); --(7 downto 0);
ReadData(15 downto 8) <= memContents(i+2); --(7 downto 0);
ReadData(7 downto 0) <= memContents(i+3); --(7 downto 0);
end process;

end beh;
