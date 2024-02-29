library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg7ctrl is
  port
  (
    mclk    : in std_logic; -- 100MHz, positive flank
    reset   : in std_logic; -- Asynchronous reset, active high
    d0      : in std_logic_vector(4 downto 0);
    d1      : in std_logic_vector(4 downto 0);
    abcdefg : out std_logic_vector(6 downto 0);
    c       : out std_logic := '0'
  );
end entity seg7ctrl;

architecture str of seg7ctrl is
  component bin2ssd is
  port(
      input    : in  std_logic_vector(4 downto 0);
      output   : out std_logic_vector(6 downto 0)
      );
  end component;
  
  signal count : std_logic_vector(3 downto 0):= "1111";
  signal binin : std_logic_vector(4 downto 0) := "00000";
  signal binout : std_logic_vector(6 downto 0) := "0000000";
signal abcdefg_i : std_logic_vector(6 downto 0) := "0000000";
  begin 

  decoder : bin2ssd
  port map
    (
     input => binin,
     output  => binout
    ); 

  process(mclk, reset)
  begin
    if rising_edge(mclk) then

      if count = "1111" then
	report "text";
        c <= not(c);
        count <= "0000";
      end if;      
      count <= std_logic_vector(unsigned(count) + 1);
      if c then
        binin <= d1;
        abcdefg_i <= binout;
      else
	binin <= d0;
        
        abcdefg_i <= binout;

      end if;
      
    end if;
    
    if reset = '1' then
      count <= "0000";
      c <= '0';
    end if;
  
  end process;
abcdefg <= abcdefg_i;
end architecture str;
