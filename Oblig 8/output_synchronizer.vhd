library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;

entity output_synchronizer is 
  port
  (
  mclk      : in std_logic;
  reset     : in std_logic;
  dir       : in std_logic;
  en        : in std_logic;
  dir_synch : out std_logic;
  en_synch  : out std_logic
  );
end entity output_synchronizer;

architecture arch of output_synchronizer is 
begin
process(mclk) is
begin
  if rising_edge(mclk) then
    if reset then
      dir_synch <= '1';
      en_synch  <= '0';
    else 
      dir_synch <= DIR;
      en_synch  <= EN;
    end if;
  end if;
end process;
end architecture arch;