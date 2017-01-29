library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX is
	port(
		controle: in std_logic;
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end MUX;

architecture mux_arq of MUX is
	begin
		process(controle)
			begin
				case controle is
					when '0' => output <= A;
					when '1' => output <= B;
					when others => null;
				end case;
			end process;
end mux_arq;