library IEEE;
  use IEEE.std_logic_1164.all; 
  use IEEE.numeric_std.all;
  
entity tb_quadrature_decoder is
 -- Empty entity of the testbench
end entity tb_quadrature_decoder;


architecture behavioral of tb_quadrature_decoder is
  
  -- 100 Mhz clock frequency
  constant HALF_PERIOD : time := 5 ns;
  constant PERIOD : time := 2* HALF_PERIOD;
  

  --components used in TB
  component quadrature_decoder is
    port
    (
    mclk       : in std_logic;
    reset      : in std_logic;
    sa         : in std_logic;
    sb         : in std_logic;
    pos_inc    : out std_logic;
    pos_dec    : out std_logic
    );
  end component;

  signal mclk : std_logic := '0';
  signal reset: std_logic := '0';
  signal sa : std_logic := '0';
  signal sb : std_logic := '0';
  signal pos_inc, pos_dec : std_logic;

  begin

  TEST_UNIT : quadrature_decoder
    port map(
      mclk => mclk,
      reset => reset,
      sa =>  sa,
      sb => sb,
      pos_inc => pos_inc,
      pos_dec => pos_dec
    );
    
  mclk <= not mclk after HALF_PERIOD;

  STIMULI: process is
   begin
   reset <= '0';
   for i in std_logic range '0' to '1' loop
     for j in std_logic range '0' to '1' loop
       for k in std_logic range '0' to '1' loop
    	 sa <= j;
         sb <= k;
         wait for 30 ns;
         for l in std_logic range '0' to '1' loop
           sa <= l;
           sb <= k;
           wait for 30 ns;
         end loop;
       end loop;
     end loop;
   reset <= '1';
   end loop;
 end process;
end architecture;
