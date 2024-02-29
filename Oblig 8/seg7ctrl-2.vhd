library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg7ctrl is
  port
  (
    mclk    : in std_logic; -- 100MHz, positive flank
    reset   : in std_logic; -- Asynchronous reset, active high
    d0      : in std_logic_vector(3 downto 0);
    d1      : in std_logic_vector(3 downto 0);
    abcdefg : out std_logic_vector(6 downto 0);
    c       : out std_logic := '0'
  );
end entity seg7ctrl;

architecture str of seg7ctrl is
  component bin2ssd is
  port(
      input    : in  std_logic_vector(3 downto 0);
      output   : out std_logic_vector(6 downto 0)
      );
  end component;
  
  signal count : std_logic_vector(19 downto 0):= "00000000000000000000";
  signal binin : std_logic_vector(3 downto 0) := "0000";
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
    if reset = '1' then
      count <= "00000000000000000000";
      c <= '0';
  
    elsif rising_edge(mclk) then
      count <= std_logic_vector(unsigned(count) + 1);
      if count >= "11110100001001000000" then
       -- report "counten";
        c <= not(c);
        count <= "00000000000000000000";
      end if;      
      
      if c then
	--report "iffen";
        binin <= d1;
        abcdefg_i <= binout;
      else
        --report "elsen";
	binin <= d0;
        
        abcdefg_i <= binout;

      end if;
      
    end if;
    

  end process;
abcdefg <= abcdefg_i;
end architecture str;
