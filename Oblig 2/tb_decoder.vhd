library IEEE;
use IEEE.std_logic_1164.all;

entity tb_decoder is
-- Empty entity of the testbench
end tb_decoder;

architecture TESTBENCH of tb_decoder is
  -- Area for declarations

  -- Component declaration
  component decoder
    port
      (
      input   : in  std_logic_vector(1 downto 0);        
      count   : out std_logic_vector(3 downto 0)
       );
  end component;

  signal tb_input     : std_logic_vector(1 downto 0) := "00"; 
  signal tb_count     : std_logic_vector(3 downto 0) := "0000";

begin
  -- Concurrent statements

  -- Instantiating the unit under test
  UUT : decoder
    port map
    (
      input       => tb_input,
      count       => tb_count
      );

  STIMULI :
  process
  begin
    wait for 100 ns;
 
    tb_input <= "00";
 
    wait for 100 ns;
 
    tb_input <= "01";
 
    wait for 100 ns;
 
    tb_input <= "10";
 
    wait for 100 ns;
 
    tb_input <= "11";
    wait;
  end process;
  
end TESTBENCH;
