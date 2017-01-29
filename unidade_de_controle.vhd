LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.ALL;


ENTITY unidade_de_controle IS
	PORT (	
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
	END unidade_de_controle ;

ARCHITECTURE arq OF unidade_de_controle is

signal PC_clr_S:  std_logic; -- clear do contador
signal	PC_inc_S: std_logic; -- ativar incremento contador
signal	data_out_S:  std_logic_vector(15 downto 0);
signal	IR_ld_S: std_logic; -- ativar incremento contador


COMPONENT contador is 
	PORT(	
		clr : IN STD_LOGIC;
		up  : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		I_ADDR : OUT STD_LOGIC_vector(15 downto 0)
	);	
	
END COMPONENT ;

COMPONENT IR is 
	port(
		data_in: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		ld: in std_logic;
		data_out: out std_logic_vector(15 downto 0)
	);
END COMPONENT;

COMPONENT Controller is 
	port(
		clk: in std_logic; -- clock
		data: in std_logic_vector(15 downto 0); -- instrução
		PC_clr: out std_logic; -- clear do contador
		PC_inc: out std_logic; -- ativar incremento contador
		IR_ld: out std_logic; -- ativar leitura do registrador de instruções
		I_rd: out std_logic; -- ativar leitura do banco de registradores de instruções
		D_addr: out std_logic_vector(7 downto 0); -- endereço da memória
		D_rd: out std_logic; -- ativar leitura memoria
		D_wr: out std_logic; -- ativar escrita memoria
		RF_s: out std_logic; -- sinal de controle do MUX
		RF_W_addr: out std_logic_vector(3 downto 0); -- endereço de escrita do banco de registradores
		RF_W_wr: out std_logic; -- ativar escrita do banco de registradores
		RF_Rp_addr: out std_logic_vector(3 downto 0); -- endereço de leitura do banco de registradores
		RF_Rp_rd: out std_logic; -- ativar leitura do banco de registradores
		RF_Rq_addr: out std_logic_vector(3 downto 0); -- endereço de leitura do banco de registradores
		RF_Rq_rd: out std_logic; -- ativar leitura do banco de registradores
		alu_s: out std_logic_vector(3 downto 0) -- sinal OPCODE pra ULA
		);	
END COMPONENT;

 BEGIN 
contador1 : contador PORT MAP (
		clr => PC_clr_S,
		up  => PC_inc_S,
		clk  => clk2,
		I_ADDR  => I_ADDR
		);

IR1: IR  PORT MAP (
		clk  => clk2,
		data_in => data_in,
		ld => IR_ld_S,
		data_out => data_out_S
		);
	
Controller1 : Controller  PORT MAP (			
		clk => clk2,
		data =>data_out_S,
		PC_clr =>PC_clr_S,
		PC_inc =>PC_inc_S,
		IR_ld =>IR_ld_S,
		I_rd =>I_rd,
		D_addr =>D_addr,
		D_rd =>D_rd,
		D_wr =>D_wr,
		RF_s =>RF_s,
		RF_W_addr => RF_W_addr,
		RF_W_wr =>RF_W_wr,
		RF_Rp_addr =>RF_Rp_addr,
		RF_Rp_rd =>RF_Rp_rd,
		RF_Rq_addr =>RF_Rq_addr,
		RF_Rq_rd =>RF_Rq_rd,
		alu_s =>alu_s
		);		

 END arq ;