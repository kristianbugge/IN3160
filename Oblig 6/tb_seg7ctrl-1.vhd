library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity tb_seg7ctrl is
-- Empty entity of the testbench
end tb_seg7ctrl;

architecture TESTBENCH of tb_seg7ctrl is

  component seg7model is
    port
      (
      c         : in  std_logic;
      abcdefg   : in  std_logic_vector(6 downto 0);
      disp1     : out std_logic_vector(4 downto 0);
      disp0     : out std_logic_vector(4 downto 0)
      );
  end component;

  component bin2ssd is
    port(
      input    : in  std_logic_vector(4 downto 0);
      output   : out std_logic_vector(6 downto 0)
      );
  end component;

  component seg7ctrl is
    port
    (
      mclk    : in std_logic; -- 100MHz, positive flank
      reset   : in std_logic; -- Asynchronous reset, active high
      d0      : in std_logic_vector(4 downto 0);
      d1      : in std_logic_vector(4 downto 0);
      abcdefg : out std_logic_vector(6 downto 0);
      c       : out std_logic
    );
  end component;

  constant HALF_PERIOD : time := 5 ns;

  signal tb_c           : std_logic;
  signal tb_abcdefg     : std_logic_vector(6 downto 0) := "0000000"; 
  signal tb_disp1       : std_logic_vector(4 downto 0) := "00000"; 
  signal tb_disp0       : std_logic_vector(4 downto 0) := "00000"; 
  signal tb_mclk        : std_logic := '0'; 
  signal tb_reset       : std_logic := '0';
  signal tb_d0          : std_logic_vector(4 downto 0) := "00000";
  signal tb_d1          : std_logic_vector(4 downto 0) := "00000"; 

  begin 

  UUT_1: entity work.seg7model(beh)
    port map
      (
       c => tb_c,
       abcdefg  => tb_abcdefg,
       disp1    => tb_disp1,
       disp0    => tb_disp0
      ); 
  UUT_2: entity work.seg7ctrl(str)
    port map
      (
       mclk   => tb_mclk,
       reset  => tb_reset,
       d0     => tb_d0,
       d1     => tb_d1,
       abcdefg=> tb_abcdefg,
       c      => tb_c
      ); 

  tb_mclk <= not tb_mclk after HALF_PERIOD;

  process
  begin
  for i in 0 to 15 loop
    tb_d0 <= std_logic_vector(to_unsigned(i, tb_d0'length));
    tb_d1 <= std_logic_vector(to_unsigned(i + 1, tb_d1'length));
    
    wait for 5000 ns;
    end loop; 
end process;
end architecture TESTBENCH;
