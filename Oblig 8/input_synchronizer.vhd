
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;

entity input_synchronizer is 
  port
  (
  mclk      : in std_logic;
  reset     : in std_logic;
  sa        : in std_logic;
  sb        : in std_logic;
  sa_synch  : out std_logic;
  sb_synch  : out std_logic
  );
end entity input_synchronizer;

architecture arch of input_synchronizer is 
  signal sa_temp    : std_logic;
  signal sb_temp    : std_logic;
begin
process(mclk) is
begin
  if rising_edge(mclk) then
    if reset then
      sa_synch  <= '0';
      sb_synch  <= '0';
    else 
      sa_temp <= sa;
      sb_temp <= sb;
      sa_synch <= sa_temp;
      sb_synch <= sb_temp;
    end if;
  end if;
end process;
end architecture arch;