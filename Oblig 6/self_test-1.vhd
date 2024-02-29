library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test is
  port
  (
  mclk    : in std_logic; -- 100MHz, positive flank
  reset   : in std_logic; -- Asynchronous reset, active high
  d0      : out std_logic_vector(4 downto 0);
  d1      : out std_logic_vector(4 downto 0)
  );
end entity self_test;


architecture arch of self_test is
  component rom is
    port ( address : in std_logic_vector(4 downto 0) := "00000";
           data : out std_logic_vector(9 downto 0) );
  end component;

  signal count : unsigned(26 downto 0):= "000000000000000000000000000";
  signal second_tick : std_logic := '0';
  signal data : std_logic_vector(9 downto 0);
  signal address : std_logic_vector(4 downto 0):= "00000";
  begin

  UUT_1: entity work.rom(behavioral)
    port map
      (
       address => address,
       data  => data
      ); 

  process(mclk, reset)
  begin
    if reset = '1' then
      count <= "000000000000000000000000000";
      second_tick <= '0';
  elsif rising_edge(mclk) then
    if count   >= "101111101011110000100000000" then
        count <= "000000000000000000000000000";
        if second_tick = '0' then
          second_tick <= '1';
        else
          second_tick <= '0';
        end if;
        
    end if;      
    count <= count + 1;
    if second_tick then
      
      address <= std_logic_vector(unsigned(address) + 1);

      end if;
    d0 <= data(9 downto 5);
    d1 <= data(4 downto 0);
    end if;
    
   
  end process;
end architecture arch;