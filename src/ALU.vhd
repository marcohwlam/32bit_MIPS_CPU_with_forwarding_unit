library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
generic (n : natural := 32);
port (a,b: in std_logic_vector(n-1 downto 0);
		Oper: in std_logic_vector(3 downto 0);
		Result: out std_logic_vector(n-1 downto 0);
		overflow,carryOut,zero: out std_logic);
end ALU;
		
architecture struc of ALU is

signal w: std_logic_vector(n-1 downto 0);
signal carry: std_logic_vector(n-1 downto 0);
signal less: std_logic;
signal cout:std_logic;
signal over: std_logic;

component ALU_PE 
port (a,b,less,ainvert,binvert,c_in:in std_logic;
		op: in std_logic_vector(1 downto 0);
		result,c_out,set,overflow: out std_logic);
end component;

begin

carry(0)<=Oper(2);

G1: for i in n-1 downto 0 generate

	G2: if i = n-1 generate
	U2: ALU_PE port map (
		a(i),b(i),'0',Oper(3),Oper(2),carry(i),Oper(1 downto 0),w(i),cout,less,over);
	end generate G2;
	
	G3: if i<n-1 and i>0 generate
	U2: ALU_PE port map (
		a(i),b(i),'0',oper(3),oper(2),carry(i),oper(1 downto 0),w(i),carry(i+1),open,open);
	end generate G3;
	
	G4: if i = 0 generate
	U2: ALU_PE port map (
		a(i),b(i),less,oper(3),oper(2),carry(i),oper(1 downto 0),w(i),carry(i+1),open,open);
	end generate G4;
	
end generate G1;


carryOut<=cout;
result(n-1 downto 1) <= w(n-1 downto 1);
overflow<=over;

result(0)<= w(0) xor over; 

process(w,over)
variable tempzero :std_logic;
begin
tempzero := '0';
for i in n-1 downto 1 loop
tempzero := tempzero or w(i);
end loop;
zero <= not (tempzero or (w(0) xor over));
end process;

end struc;