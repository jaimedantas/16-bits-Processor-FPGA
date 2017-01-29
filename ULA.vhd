library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ULA is
	port(
		sinal_controle: in std_logic_vector(3 downto 0);
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0)
	);
end ULA;

architecture arq of ULA is

	begin
		uso_ula: process(sinal_controle)
			begin
				case sinal_controle is 
					when "0000" => 
					output <= A; -- LDA, load
					when "0001" => 
					output <= A; -- STA, store
					when "0010" => 
					output <= A + B; -- ADD
					when "0011" => 
					output <= A - B; -- SUB
					when "0100" => 
					output <= A and B; -- AND
					when "0101" => 
					output <= A or B; -- OR
					when "0110" => 
					output <= not A; -- NOT
					when others => null;
				end case;
		end process uso_ula;
end arq;