LIBRARY Ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.ALL;


ENTITY PC IS
	PORT (
		clock: in std_logic;--ok
		led : out std_logic;
		display1 : inout std_logic_vector(6 downto 0);--para display no fpga
		display2 : inout std_logic_vector(6 downto 0)--para display no fpga
		);
	END PC ;
	
	
	
ARCHITECTURE arq OF PC is

----------------------SINAIS
		signal I_rd, D_rd, D_wr, RF_s, RF_w_wr, RF_rp_rd, RF_rq_rd : std_logic;
		signal RF_w_addr, RF_rp_addr, RF_rq_addr, alu_s : std_logic_vector(3 downto 0);
		signal D_addr : std_LOGIC_vector(7 downto 0);
		signal data_in, I_ADDR, W_data, R_data	: std_LOGIC_vector(15 downto 0);
		
---------------------

COMPONENT datapath is 
	port(
		R_data: in std_logic_vector(15 downto 0);
		W_data2: inout std_logic_vector(15 downto 0);
		RF_w_addr: in std_logic_vector(3 downto 0);
		RF_w_wr: in std_logic;
		RF_rp_addr: in std_logic_vector(3 downto 0);
		RF_rp_rd: in std_logic;
		RF_rq_addr: in std_logic_vector(3 downto 0);
		RF_rq_rd: in std_logic;
		RF_s: in std_logic;
		clk2: in std_logic;
		alu_s: in std_logic_vector(3 downto 0);
		display1 : out std_logic_vector(6 downto 0);--para display no fpga
		display2 : out std_logic_vector(6 downto 0)--para display no fpga
	);
END COMPONENT ;

COMPONENT banco_instrucao is 
	port(
		addr: in std_logic_vector(15 downto 0);
		data: out std_logic_vector(15 downto 0);
		rd: in std_logic;
		clk: in std_logic
	);
END COMPONENT ;

COMPONENT memoria is 
	port(
		addr: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		rd: in std_logic;
      wr: in std_logic;
		W_data: in std_logic_vector(15 downto 0);
		R_data: out std_logic_vector(15 downto 0)
	);
END COMPONENT ;

COMPONENT unidade_de_controle is 
	port(
		D_addr: inout std_logic_vector(7 downto 0);-- endereço na memoria a ser usada
		D_rd: inout std_logic; -- ativar leitura da memoria
		D_wr: inout std_logic; --- ativar escrita da memoria
		RF_w_addr: inout std_logic_vector(3 downto 0);
		RF_w_wr: inout std_logic;
		RF_rp_addr: inout std_logic_vector(3 downto 0);
		RF_rp_rd: inout std_logic;
		RF_rq_addr: inout std_logic_vector(3 downto 0);
		RF_rq_rd: inout std_logic;
		RF_s: inout std_logic; -- sinal de controle do mux
		clk2: in std_logic;
		alu_s: inout std_logic_vector(3 downto 0);
		I_rd:  inout std_logic; -- ativar leitura do banco de registradores de instruções
		data_in: in std_logic_vector(15 downto 0); --entrada do banco de instrução
		I_ADDR : inout STD_LOGIC_vector(15 downto 0) -- saida do contador, endereço onde está a instrução

	);
END COMPONENT ;


BEGIN 
 
led <= clock;

datapath1 : datapath PORT MAP (--OK
		R_data => R_data,
		W_data2 => W_data,--ENTRADA NA MEMORIA
		RF_w_addr => RF_w_addr,
		RF_w_wr => RF_w_wr,
		RF_rp_addr => RF_rp_addr,
		RF_rp_rd => RF_rp_rd,
		RF_rq_addr => RF_rq_addr,
		RF_rq_rd => RF_rq_rd,
		RF_s => RF_s,
		clk2 => clock,
		alu_s => alu_s,
		display1 => display1,
		display2 => display2
					);

banco_instrucao1 : banco_instrucao PORT MAP (--OK
		addr => I_ADDR,
		data => data_in,
		rd => I_rd,
		clk => clock
					);
					
memoria1 : memoria PORT MAP (--OK
		addr => D_addr,
		clk => clock,
		rd => D_rd,
      wr => D_wr,
		W_data => W_data,
		R_data => R_data
					);
					
unidade_de_controle1 : unidade_de_controle PORT MAP (--OK
		D_addr => D_addr,
		D_rd => D_rd,
		D_wr => D_wr ,
		RF_w_addr => RF_w_addr,
		RF_w_wr =>RF_w_wr ,
		RF_rp_addr =>RF_rp_addr ,
		RF_rp_rd => RF_rp_rd,
		RF_rq_addr => RF_rq_addr,
		RF_rq_rd =>RF_rq_rd ,
		RF_s =>RF_s ,
		clk2 => clock ,
		alu_s => alu_s,
		I_rd => I_rd,
		data_in =>data_in ,
		I_ADDR => I_ADDR 
					);

 END arq ;