library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity display is
	port(
		input: in std_logic_vector(15 downto 0);
		display1: out std_logic_vector(6 downto 0);
		display2: out std_logic_vector(6 downto 0)
	);
end display;

architecture arq of display is
		constant zero: std_logic_vector(6 downto 0) := "1000000";
		constant um: std_logic_vector(6 downto 0) := "1111001";
		constant dois: std_logic_vector(6 downto 0) := "0100100";
		constant tres: std_logic_vector(6 downto 0) := "0110000";
		constant quatro: std_logic_vector(6 downto 0) := "0011001";
		constant cinco: std_logic_vector(6 downto 0) := "0010010";
		constant seis: std_logic_vector(6 downto 0) := "0000010";
		constant sete: std_logic_vector(6 downto 0) := "1111000";
		constant oito: std_logic_vector(6 downto 0) := "0000000";
		constant nove: std_logic_vector(6 downto 0) := "0010000";
		signal input_s : std_logic_vector(15 downto 0);
		begin
		input_s <= input;
			process(input_s)
				begin
				case input_s is
					when "0000000000000000" => 
					display1 <= zero;
					display2 <= zero;
					when "0000000000000001" => 
					display1 <= um;
					display2 <= zero;
					when "0000000000000010" => 
					display1 <= dois;
					display2 <= zero;
					when "0000000000000011" => 
					display1 <= tres;
					display2 <= zero;
					when "0000000000000100" => 
					display1 <= quatro;
					display2 <= zero;
					when "0000000000000101" => 
					display1 <= cinco;
					display2 <= zero;
					when "0000000000000110" => 
					display1 <= seis;
					display2 <= zero;
					when "0000000000000111" => 
					display1 <= sete;
					display2 <= zero;
					when "0000000000001000" => 
					display1 <= oito;
					display2 <= zero;
					when "0000000000001001" => 
					display1 <= nove;	
					display2 <= zero;
					--
					when "0000000000001010" => --10
					display2 <= um;
					display1 <= zero;
					when "0000000000001011" => --11
					display2 <= um;
					display1 <= um;
					when "0000000000001100" => --12
					display2 <= um;
					display1 <= dois;
					when "0000000000001101" => --13
					display2 <= um;
					display1 <= tres;
					when "0000000000001110" => --14
					display2 <= um;
					display1 <= quatro;
					when "0000000000001111" => --15
					display2 <= um;
					display1 <= cinco;
					when others => 
					display2 <= nove;
					display1 <= nove;
				end case;
			end process;
end arq;