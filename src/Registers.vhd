library ieee ;
	use ieee.std_logic_1164.all ;
	--use ieee.numeric_std.all ;

entity Registers is
  port (
  RR1, RR2, WR: in std_logic_vector(4 downto 0);
  WD: in std_logic_vector(31 downto 0);
  RegWrite: in std_logic;
  RD1, RD2: out std_logic_vector(31 downto 0)) ;
end Registers ;

architecture arch of Registers is
	type myregister is array (natural range<>) of std_logic_vector(31 downto 0);
	--Initialization goes here
	signal reg: myregister(0 to 31) := (0 => "00000000000000000000000000000000",
					8 => "00000000000000000000000000000000",
					9 => "00000000000000000000000000000100",
					10 => "00000000000000000000000000000100",
					20 => "00000000000000000000000000001110",
					21 => "00000000000000000000000000000101",
					22 => "00000000000000000000000000001000",
					23 => "00000000000000000000000000000011",
					others => "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
	--signal flag: std_logic := '0';

begin
    

process(rr1, rr2, reg)
--variable flag :integer := 1;
begin
--if(flag = '0') then
--	reg(0) <= (others => '0');
--	reg(8) <= (others => '0');
--	reg(20) <= x"00000014";
--"00000000000000000000000000001110";
--	reg(21) <= "00000000000000000000000000000101";		
	
	--flag <= '1';

--else 
--read from register 1
	case RR1 is
		when "00000" =>
			RD1 <= reg(0);
		when "00001" =>
			RD1 <= reg(1);
		when "00010" =>
			RD1 <= reg(2);
		when "00011" =>
			RD1 <= reg(3);
		when "00100" =>
			RD1 <= reg(4);
		when "00101" =>
			RD1 <= reg(5);
		when "00110" =>
			RD1 <= reg(6);
		when "00111" =>
			RD1 <= reg(7);
		when "01000" =>
			RD1 <= reg(8);
		when "01001" =>
			RD1 <= reg(9);
		when "01010" =>
			RD1 <= reg(10);
		when "01011" =>
			RD1 <= reg(11);
		when "01100" =>
			RD1 <= reg(12);
		when "01101" =>
			RD1 <= reg(13);
		when "01110" =>
			RD1 <= reg(14);
		when "01111" =>
			RD1 <= reg(15);
		when "10000" =>
			RD1 <= reg(16);
		when "10001" =>
			RD2 <= reg(17);
		when "10010" =>
			RD1 <= reg(18);
		when "10011" =>
			RD1 <= reg(19);
		when "10100" =>
			RD1 <= reg(20);
		when "10101" =>
			RD1 <= reg(21);
		when "10110" =>
			RD1 <= reg(22);
		when "10111" =>
			RD1 <= reg(23);
		when "11000" =>
			RD1 <= reg(24);
		when "11001" =>
			RD1 <= reg(25);
		when "11010" =>
			RD1 <= reg(26);
		when "11011" =>
			RD1 <= reg(27);
		when "11100" =>
			RD1 <= reg(28);
		when "11101" =>
			RD1 <= reg(29);
		when "11110" =>
			RD1 <= reg(30);
		when "11111" =>
			RD1 <= reg(31);
when others => null;
	end case;
--read from register 2
	case RR2 is
		when "00000" =>
			RD2 <= reg(0);
		when "00001" =>
			RD2 <= reg(1);
		when "00010" =>
			RD2 <= reg(2);
		when "00011" =>
			RD2 <= reg(3);
		when "00100" =>
			RD2 <= reg(4);
		when "00101" =>
			RD2 <= reg(5);
		when "00110" =>
			RD2 <= reg(6);
		when "00111" =>
			RD2 <= reg(7);
		when "01000" =>
			RD2 <= reg(8);
		when "01001" =>
			RD2 <= reg(9);
		when "01010" =>
			RD2 <= reg(10);
		when "01011" =>
			RD2 <= reg(11);
		when "01100" =>
			RD2 <= reg(12);
		when "01101" =>
			RD2 <= reg(13);
		when "01110" =>
			RD2 <= reg(14);
		when "01111" =>
			RD2 <= reg(15);
		when "10000" =>
			RD2 <= reg(16);
		when "10001" =>
			RD2 <= reg(17);
		when "10010" =>
			RD2 <= reg(18);
		when "10011" =>
			RD2 <= reg(19);
		when "10100" =>
			RD2 <= reg(20);
		when "10101" =>
			RD2 <= reg(21);
		when "10110" =>
			RD2 <= reg(22);
		when "10111" =>
			RD2 <= reg(23);
		when "11000" =>
			RD2 <= reg(24);
		when "11001" =>
			RD2 <= reg(25);
		when "11010" =>
			RD2 <= reg(26);
		when "11011" =>
			RD2 <= reg(27);
		when "11100" =>
			RD2 <= reg(28);
		when "11101" =>
			RD2 <= reg(29);
		when "11110" =>
			RD2 <= reg(30);
		when "11111" =>
			RD2 <= reg(31);
when others => null;
	end case;
--end if;
end process;

--write data
process(RegWrite,WD,WR)
begin
	if RegWrite = '1' then
		case WR is
			when "00000" =>
				reg(0) <= WD;
			when "00001" =>
				reg(1) <= WD;
			when "00010" =>
				reg(2) <= WD;
			when "00011" =>
				reg(3) <= WD;
			when "00100" =>
				reg(4) <= WD;
			when "00101" =>
				reg(5) <= WD;
			when "00110" =>
				reg(6) <= WD;
			when "00111" =>
				reg(7) <= WD;
			when "01000" =>
				reg(8) <= WD;
			when "01001" =>
				reg(9) <= WD;
			when "01010" =>
				reg(10) <= WD;
			when "01011" =>
				reg(11) <= WD;
			when "01100" =>
				reg(12) <= WD;
			when "01101" =>
				reg(13) <= WD;
			when "01110" =>
				reg(14) <= WD;
			when "01111" =>
				reg(15) <= WD;
			when "10000" =>
				reg(16) <= WD;
			when "10001" =>
				reg(17) <= WD;
			when "10010" =>
				reg(18) <= WD;
			when "10011" =>
				reg(19) <= WD;
			when "10100" =>
				reg(20) <= WD;
			when "10101" =>
				reg(21) <= WD;
			when "10110" =>
				reg(22) <= WD;
			when "10111" =>
				reg(23) <= WD;
			when "11000" =>
				reg(24) <= WD;
			when "11001" =>
				reg(25) <= WD;
			when "11010" =>
				reg(26) <= WD;
			when "11011" =>
				reg(27) <= WD;
			when "11100" =>
				reg(28) <= WD;
			when "11101" =>
				reg(29) <= WD;
			when "11110" =>
				reg(30) <= WD;
			when "11111" =>
				reg(31) <= WD;
when others => null;
			end case;
	end if;
end process;
end architecture ; -- arch
