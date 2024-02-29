library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test_system is
  port
  (
  mclk    : in std_logic; -- 100MHz, positive flank
  reset   : in std_logic; -- Asynchronous reset, active high
  abcdefg : out std_logic_vector(6 downto 0);
  c       : out std_logic
  );
end entity self_test_system;

architecture arch of self_test_system is
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

component self_test is
  port
  (
  mclk    : in std_logic; -- 100MHz, positive flank
  reset   : in std_logic; -- Asynchronous reset, active high
  d0      : out std_logic_vector(4 downto 0);
  d1      : out std_logic_vector(4 downto 0)
  );
end component;

signal testd0 : std_logic_vector(4 downto 0);
signal testd1 : std_logic_vector(4 downto 0);

begin
  ctrl: seg7ctrl
    port map
      (
       mclk   => mclk,
       reset  => reset,
       d0     => testd0,
       d1     => testd1,
       abcdefg=> abcdefg,
       c      => c
      ); 
  test: self_test
    port map
      (
      mclk    => mclk,
      reset   => reset,
      d0      => testd0,
      d1      => testd1
      );
end architecture arch;