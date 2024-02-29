library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shiftn is
-- Empty entity of the testbench
end tb_shiftn;

architecture TESTBENCH of tb_shiftn is
  component shiftn
    generic(
    number : positive
   );
    port ( 
    -- System Clock and Reset
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    -- Shifted data in and out
    din       : in  std_logic;   -- Data in
    dout      : out std_logic;    -- Data out
    pout      : out std_logic_vector(number - 1 downto 0)
    );
  end component;
  constant cnumber : positive := 64;
  signal tb_rst_n  : std_logic := '0';
  signal tb_mclk   : std_logic := '0';
  signal tb_din    : std_logic;
  signal tb_dout   : std_logic := '0';
  signal tb_pout   : std_logic_vector(cnumber - 1 downto 0);
  constant HALF_PERIOD : time := 10 ns;

begin

  UUT: shiftn
    generic map
      (
       number=> cnumber
     )
    port map
      (
       rst_n => tb_rst_n,
       mclk  => tb_mclk,   
       din   => tb_din,    
       dout  => tb_dout,
       pout  => tb_pout
       
      ); 
  
  tb_mclk <= not tb_mclk after HALF_PERIOD;

STIMULI :
  process
    begin
      tb_rst_n <= '0', '1' after 2*HALF_PERIOD;

      wait for 2*HALF_PERIOD;
      tb_din <= '1';

      wait for 2*HALF_PERIOD;

      tb_din <= '0';
      
    wait;
  end process;
end TESTBENCH;
