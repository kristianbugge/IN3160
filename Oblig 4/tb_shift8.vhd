library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift8 is
-- Empty entity of the testbench
end tb_shift8;

architecture TESTBENCH of tb_shift8 is
  component shift8
    port ( 
    -- System Clock and Reset
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    -- Shifted data in and out
    din       : in  std_logic;   -- Data in
    dout      : out std_logic;    -- Data out
    pout      : out std_logic_vector(7 downto 0)
    );
  end component;
  
  signal tb_rst_n  : std_logic := '0';
  signal tb_mclk   : std_logic := '0';
  signal tb_din    : std_logic;
  signal tb_dout   : std_logic := '0';
  signal tb_pout   : std_logic_vector(7 downto 0) := "00000000";
  constant HALF_PERIOD : time := 10 ns;

begin

  UUT: shift8
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