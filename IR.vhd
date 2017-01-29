library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IR is
	port(
		data_in: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		ld: in std_logic;
		data_out: out std_logic_vector(15 downto 0));
end IR;

architecture arq of IR is
	begin
		process(clk)
			begin
				if rising_edge(clk) and ld='1' then
					data_out <= data_in;
				end if;
		end process;
end arq;