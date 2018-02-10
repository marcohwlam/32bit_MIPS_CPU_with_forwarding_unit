library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end ALUControl;

architecture beh of ALUControl is
begin

process(ALUOp,Funct)
variable outPut : std_logic_vector(3 downto 0);
	begin	
	if ALUOp = "00" then 
		outPut := "0010";
	elsif ALUOp = "01" then 
		outPut := "0110";
	elsif ALUOp = "10" and Funct = "100100" then 
		outPut := "0000";
	elsif ALUOp = "10" and Funct = "100101" then
		outPut := "0001";
	elsif ALUOp = "10" and Funct = "100000" then
		outPut := "0010";
	elsif ALUOp = "10" and Funct = "100010"  then
		outPut := "0110";	
	elsif ALUOp = "10" and Funct = "101010"  then
		outPut := "0111";	
	end if;
	Operation <= outPut;
end process; 
end beh;

-- 0000 AND
-- 0001 OR
-- 0010 ADD
-- 0110 SUB
-- 0111 SLT
-- 1100 NOr

--ALUOp1 ALUOp0 F5 F4 F3 F2 F1 F0
--0 0 XXXXXX 0010
--0 1 XXXXXX 0110
--1 0 XX0000 0010
--1 X XX0010 0110
--1 0 XX0100 0000
--1 0 XX0101 0001
--1 X XX1010 0111
--FIGURE D.2.1 The truth table for the 4 ALU control bits (called Operation) as a function 