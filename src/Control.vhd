library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Control is
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end Control;

architecture beh of Control is

begin
process(Opcode)

begin
    C1: case Opcode is
	--R-format
	when "000000" => RegDst <= '1';
			 Branch <= '0';
			 MemRead <= '0';
			 MemtoReg<='0';
			 MemWrite<='0';
			 ALUSrc<='0';
			 RegWrite<='1';
			 Jump<='0';
			 ALUOp <="10";
	--lw
	when "100011" => RegDst <= '0';
			 Branch<='0';
			 MemRead<='1';
			 MemtoReg<='1';
			 MemWrite<='0';
			 ALUSrc<='1';
			 RegWrite<='1';
			 Jump<='0';
			 ALUOp <="00";
	--sw
	when "101011" => RegDst <= 'U';
			 Branch<='0';
			 MemRead<='0';
			 MemtoReg<='U';
			 MemWrite<='1';
			 ALUSrc<='1';
			 RegWrite<='0';
			 Jump<='0';
			 ALUOp <="00";
	--beq
	when "000100" => RegDst <= 'U';
			 Branch<='1';
			 MemRead<='0';
			 MemtoReg<='U';
			 MemWrite<='0';
			 ALUSrc<='0';
			 RegWrite<='0';
			 Jump<='0';
			 ALUOp <="01";
	--j
	when "000010" => RegDst <= 'U';
			 Branch<='0';
			 MemRead<='0';
			 MemtoReg<='U';
			 MemWrite<='0';
			 ALUSrc<='U';
			 RegWrite<='0';
			 Jump<='1';
			 ALUOp <="UU";
	when others => null;
    end case C1;
end process;
end beh;
