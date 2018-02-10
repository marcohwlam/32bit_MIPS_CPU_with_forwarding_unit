library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all, IEEE.STD_LOGIC_unsigned.all;

entity PipelineCPUExtra is
port(clk:in std_logic; Overflow:out std_logic);
end PipelineCPUExtra;

architecture beh of PipelineCPUExtra is

signal four: std_logic_vector(31 downto 0);
signal addop: std_logic_vector(3 downto 0);
signal A: std_logic_vector(31 downto 0);
signal inst0,inst1: std_logic_vector(31 downto 0);
signal L0,L1,L2: std_logic_vector(31 downto 0);
signal inst31_26: std_logic_vector(5 downto 0);
signal inst25_21_0,inst25_21_1: std_logic_vector(4 downto 0);
signal inst20_16_0,inst20_16_1: std_logic_vector(4 downto 0);
signal inst15_11_0,inst15_11_1: std_logic_vector(4 downto 0);
signal inst15_0: std_logic_vector(15 downto 0);
signal inst25_0: std_logic_vector(25 downto 0);
signal inst5_0: std_logic_vector(5 downto 0);
signal Q0,Q1: std_logic_vector(31 downto 0);
signal B0,B1,B2: std_logic_vector(4 downto 0);
signal RegDst00,Jump00,Branch00,MemRead00,MemtoReg00,MemWrite00,ALUSrc00,RegWrite00: std_logic;
signal RegDst0,Jump0,Branch0,MemRead0,MemtoReg0,MemWrite0,ALUSrc0,RegWrite0: std_logic;
signal RegDst1,Jump1,Branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1: std_logic;
signal Branch2,MemRead2,MemWrite2,RegWrite2,MemtoReg2: std_logic;
signal PCWrite,MUXSel,IFIDWrite:std_logic;
signal RegWrite3,MemtoReg3: std_logic;
signal ALUOp00: std_logic_vector(1 downto 0);
signal ALUOp0: std_logic_vector(1 downto 0);
signal ALUOp1: std_logic_vector(1 downto 0);
signal C0,C1,C2: std_logic_vector(31 downto 0);
signal D0,D01,D1,D2: std_logic_vector(31 downto 0);
signal E0,E1: std_logic_vector(31 downto 0);
signal K: std_logic_vector(31 downto 0);
signal F: std_logic_vector(31 downto 0);
signal G0,G1,G2: std_logic_vector(31 downto 0);
signal operation: std_logic_vector(3 downto 0);
signal zero0,zero1: std_logic;
signal PCSrc: std_logic;
signal M0,M1: std_logic_vector(31 downto 0);
signal N: std_logic_vector(31 downto 0);
signal P: std_logic_vector(31 downto 0);
signal H0,H1: std_logic_vector(31 downto 0);
signal J: std_logic_vector(31 downto 0);
signal ForwardA,ForwardB: std_logic_vector(1 downto 0);

-- IF
component PC
port(clk:in std_logic;
	 PCWrite: in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end component;

component InstMemory
port(Address:in std_logic_vector(31 downto 0);  
     ReadData:out std_logic_vector(31 downto 0));
end component;

component ALU
generic (n : natural := 32);
port (a,b: in std_logic_vector(n-1 downto 0);
		Oper: in std_logic_vector(3 downto 0);
		Result: out std_logic_vector(n-1 downto 0);
		overflow,carryOut,zero: out std_logic);
end component;
 
 -- IF/ID
component IFID
PORT(
    instIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	addressIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk: IN STD_LOGIC; -- clock.
	IFIDWrite: IN STD_LOGIC;
    instOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	addressOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END component;

--ID
component ZeroGenerator
port(x,y : in std_logic_vector(31 downto 0);
	 zero : out std_logic);
end component;

component HazardDetectionUnit
	port(IDEXMemRead: in std_logic;
		 IDEXRegisterRt: in std_logic_vector(4 downto 0); 
		 IFIDRegisterRs: in std_logic_vector(4 downto 0);
		 IFIDRegisterRt: in std_logic_vector(4 downto 0);

		 sel: out std_logic;
		 IFIDWrite: out std_logic;
		 PCWrite: out std_logic);
end component;

component ControlMUX
port(sel:in std_logic;
	 RegDstIn,BranchIn,MemReadIn,MemtoRegIn,MemWriteIn,ALUSrcIn,RegWriteIn,JumpIn:in std_logic;
     ALUOpIn:in std_logic_vector(1 downto 0);
	 RegDstOut,BranchOut,MemReadOut,MemtoRegOut,MemWriteOut,ALUSrcOut,RegWriteOut,JumpOut:out std_logic;
     ALUOpOut:out std_logic_vector(1 downto 0));
end component;

component Registers
  port (
  RR1, RR2, WR: in std_logic_vector(4 downto 0);
  WD: in std_logic_vector(31 downto 0);
  RegWrite: in std_logic;
  RD1, RD2: out std_logic_vector(31 downto 0)) ;
end component ;

component ShiftLeft2Jump
port(x: in std_logic_vector(3 downto 0);
 y: in std_logic_vector(25 downto 0); 
z:out std_logic_vector(31 downto 0));
end component;

component Control
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end component;

component SignExtend
port(x:in std_logic_vector(15 downto 0);y:out std_logic_vector(31 downto 0));
end component;

-- ID/EX
component IDEX
PORT(
	clk: IN STD_LOGIC;
	RegDstIn,ALUSrcIn,BranchIn,MemReadIn,MemWriteIn,JumpIn,RegWriteIn,MemtoRegIn,ZeroIn:in std_logic;
    ALUOpIn:in std_logic_vector(1 downto 0);
	addressIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	RD1In,RD2In,signExIn:in std_logic_vector(31 downto 0);
	jumpAddIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	rsIn,rtIn,tdIn:in std_logic_vector(4 downto 0);   
	
    RegDstOut,ALUSrcOut,BranchOut,MemReadOut,MemWriteOut,JumpOut,RegWriteOut,MemtoRegOut,ZeroOut:out std_logic;
    ALUOpOut:out std_logic_vector(1 downto 0);
	addressOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	RD1Out,RD2Out,signExOut:out std_logic_vector(31 downto 0);
	jumpAddOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	rsOut,rtOut,tdOut:out std_logic_vector(4 downto 0));
END component;

-- EX
component ThreeInputMUX32
port(x,y,z:in std_logic_vector (31 downto 0);
     sel:in std_logic_vector(1 downto 0);
     w:out std_logic_vector(31 downto 0));
end component;

component ForwardingUnit
	port(EXMEMRegWrite: in std_logic;
		 MEMWBRegWrite: in std_logic;
		 MEMWBRegisterRd: in std_logic_vector(4 downto 0); 
		 EXMEMRegisterRd: in std_logic_vector(4 downto 0); 
		 IDEXRegisterRs: in std_logic_vector(4 downto 0);
		 IDEXRegisterRt: in std_logic_vector(4 downto 0);

		 ForwardA: out std_logic_vector(1 downto 0);
		 ForwardB: out std_logic_vector(1 downto 0));
end component;	

component ShiftLeft2
  port(x:in std_logic_vector(31 downto 0);
       y:out std_logic_vector(31 downto 0));
end component;

component MUX32
port(x,y:in std_logic_vector (31 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(31 downto 0));
end component;

component MUX5
port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
end component;

component ALUControl
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end component;

-- EX/MEM
component EXMEM
PORT(
	clk: IN STD_LOGIC;
	MemReadIn,MemWriteIn,RegWriteIn,MemtoRegIn:in std_logic;
	addResultIn,ALUResultIn,RD2In: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	WRIn:in std_logic_vector(4 downto 0);   
	
    MemReadOut,MemWriteOut,RegWriteOut,MemtoRegOut:out std_logic;
	addResultOut,ALUResultOut,RD2Out: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	WROut:out std_logic_vector(4 downto 0));
END component;

-- MEM
component AND2
	port(x,y:in std_logic;
	z:out std_logic);
end component;

component DataMemory
Port ( MemRead,MemWrite:in std_logic;
Address : in std_logic_vector(31 downto 0); -- write address to store the data into ram
WriteData : in std_logic_vector(31 downto 0); -- input data to store into ram	
ReadData : out std_logic_vector(31 downto 0)); -- output data from memory	
end component;	

-- MEM/WB
component MEMWB
PORT(
	clk: IN STD_LOGIC;
	RegWriteIn,MemtoRegIn:in std_logic;
	dataIn,ALUResultIn: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	WRIn:in std_logic_vector(4 downto 0);   
	
    RegWriteOut,MemtoRegOut:out std_logic;
	dataOut,ALUResultOut: out STD_LOGIC_VECTOR(31 DOWNTO 0);
	WROut:out std_logic_vector(4 downto 0));
END component;

-- WB

begin
four(2 downto 0) <= "100"; four(31 downto 3) <= (others=>'0');
addop <= "0010";
inst31_26 <= inst1(31 downto 26);
inst25_21_0 <= inst1(25 downto 21);
inst20_16_0 <= inst1(20 downto 16);
inst15_11_0 <= inst1(15 downto 11);
inst15_0 <= inst1(15 downto 0);
inst25_0 <= inst1(25 downto 0);
inst5_0 <= inst1(5 downto 0);

-- IF
U1: PC port map (clk,PCWrite,P,A);
U2: ALU port map (A,four,addop,L0,Overflow,open,open);
U3: InstMemory port map (A,inst0);

-- IF/ID
U4: IFID port map (inst0,L0,clk,IFIDWrite,inst1,L1);

-- ID
U5: ShiftLeft2Jump port map (L1(3 downto 0),inst25_0,Q0);
U6: Control port map (inst31_26,RegDst00,Branch00,MemRead00,MemtoReg00,MemWrite00,ALUSrc00,RegWrite00,Jump00,ALUOp00);
U7: Registers port map (inst25_21_0,inst20_16_0,B2,J,RegWrite3,C0,D0);
U8: SignExtend port map (inst15_0,E0);
U23: HazardDetectionUnit port map (MemRead1,inst20_16_1,inst25_21_0,inst20_16_0,MUXSel,IFIDWrite,PCWrite);
U24: ControlMUX port map (MUXSel,RegDst00,Branch00,MemRead00,MemtoReg00,MemWrite00,ALUSrc00,RegWrite00,Jump00,ALUOp00,RegDst0,Branch0,MemRead0,MemtoReg0,MemWrite0,ALUSrc0,RegWrite0,Jump0,ALUOp0);
U28: ZeroGenerator port map (C0,D0,zero0);

-- ID/EX
U9: IDEX port map (clk,RegDst0,ALUSrc0,Branch0,MemRead0,MemWrite0,Jump0,RegWrite0,MemtoReg0,Zero0,ALUOp0,L1,C0,D0,E0,Q0,inst25_21_0,inst20_16_0,inst15_11_0,RegDst1,ALUSrc1,Branch1,MemRead1,MemWrite1,Jump1,RegWrite1,MemtoReg1,Zero1,ALUOp1,L2,C1,D01,E1,Q1,inst25_21_1,inst20_16_1,inst15_11_1);

-- EX
U10: ShiftLeft2 port map (E1,K);
U11: ALU port map (L2,K,addop,M0,Overflow,open,open);
U12: MUX32 port map (D1,E1,ALUSrc1,F);
U13: ALU port map (C2,F,Operation,G0,Overflow,open,open);
U14: ALUControl port map (ALUOp1,E1(5 downto 0),operation);
U15: MUX5 port map (inst20_16_1,inst15_11_1,RegDst1,B0);
U25: ThreeInputMUX32 port map (C1,J,G1,ForwardA,C2);
U26: ThreeInputMUX32 port map (D01,G1,J,ForwardB,D1);
U27: ForwardingUnit port map (RegWrite2,RegWrite3,B2,B1,inst25_21_1,inst20_16_1,ForwardA,ForwardB);
U17: AND2 port map (Branch1,zero1,PCSrc);
U19: MUX32 port map (L0,M0,PCSrc,N);
U20: MUX32 port map (N,Q1,Jump1,P);
-- EX/MEM
U16: EXMEM port map (clk,MemRead1,MemWrite1,RegWrite1,MemtoReg1,M0,G0,D1,B0,MemRead2,MemWrite2,RegWrite2,MemtoReg2,M1,G1,D2,B1);

-- MEM
U18: DataMemory port map (MemRead2,MemWrite2,G1,D2,H0);


-- MEM/WB
U21: MEMWB port map (clk,RegWrite2,MemtoReg2,H0,G1,B1,RegWrite3,MemtoReg3,H1,G2,B2);

-- WB
U22: MUX32 port map (G2,H1,MemtoReg3,J);

end beh;