library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ControlMUX is
port(sel:in std_logic;
	 RegDstIn,BranchIn,MemReadIn,MemtoRegIn,MemWriteIn,ALUSrcIn,RegWriteIn,JumpIn:in std_logic;
     ALUOpIn:in std_logic_vector(1 downto 0);
	 RegDstOut,BranchOut,MemReadOut,MemtoRegOut,MemWriteOut,ALUSrcOut,RegWriteOut,JumpOut:out std_logic;
     ALUOpOut:out std_logic_vector(1 downto 0));
end ControlMUX;

architecture beh of ControlMUX is
begin
process(sel,RegDstIn,BranchIn,MemReadIn,MemtoRegIn,MemWriteIn,ALUSrcIn,RegWriteIn,JumpIn,ALUOpIn)
begin
if sel='1' then
	RegDstOut<=RegDstIn;
	BranchOut<=BranchIn;
	MemReadOut<=MemReadIn;
	MemtoRegOut<=MemtoRegIn;
	MemWriteOut<=MemWriteIn;
	ALUSrcOut<=ALUSrcIn;
	RegWriteOut<=RegWriteIn;
	JumpOut<=JumpIn;
	ALUOpOut<=ALUOpIn;
else
	RegDstOut<='0';
	BranchOut<='0';
	MemReadOut<='0';
	MemtoRegOut<='0';
	MemWriteOut<='0';
	ALUSrcOut<='0';
	RegWriteOut<='0';
	JumpOut<='0';
	ALUOpOut<="00";
end if;
end process;
	
end beh;