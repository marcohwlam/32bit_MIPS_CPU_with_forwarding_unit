library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_PE is
port (a,b,less,ainvert,binvert,c_in:in std_logic;
		op: in std_logic_vector(1 downto 0);
		result,c_out,set,overflow: out std_logic);
end ALU_PE;

architecture beh of ALU_PE is
signal tempa: std_logic;
signal tempb: std_logic;
signal r0: std_logic;
signal r1: std_logic;
signal r2: std_logic;
signal temp_out: std_logic;
begin

process(a,ainvert,op) -- Ainvert
begin
if ainvert = '0' then
	tempa <= a;
else
	tempa <= not a;
end if;
end process;

process(b,binvert) -- Binvert
begin
if binvert = '0' then
	tempb <= b;
else
	tempb <= not b;
end if;
end process;

process(tempa,tempb) -- AND gate
begin
r0 <= tempa and tempb;
end process;

process(tempa,tempb) -- OR gate
begin
r1 <= tempa or tempb;
end process;

process(tempa,tempb,c_in) -- FULL ADDER
begin
temp_out <= (c_in and tempa) or (tempa and tempb) or (tempb and c_in);
r2 <= tempa xor tempb xor c_in;
end process;
set <= r2;
c_out<=temp_out;

process(r0,r1,r2,less,op) -- MUX
begin
case op is
	when "00" => result <= r0;
	when "01" => result <= r1;
	when "10" => result <= r2;
	when "11" => result <= less;
	when others => null;
end case;
end process;

process(r2,temp_out,tempa,tempb,binvert) -- Overflow detection
begin
if tempa = '0' and tempb = '0' and binvert = '0' then
	if r2 = '1' then
		overflow <= '1';
	else
		overflow <= '0';
	end if;
elsif tempa = '1' and tempb = '1' and binvert = '0' then
	if r2 = '0' then
		overflow <= '1';
	else
		overflow <= '0';
	end if;
elsif tempa = '0' and tempb = '0' and binvert = '1' then
	if r2 = '1' then
		overflow <= '1';
	else
		overflow <= '0';
	end if;
elsif tempa = '1' and tempb = '1' and binvert = '1' then
	if r2 = '0' then
		overflow <= '1';
	else
		overflow <= '0';
	end if;
else
	overflow <= '0';
end if;
end process;

end beh;
