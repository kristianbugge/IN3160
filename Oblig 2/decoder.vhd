library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DECODER is
  port(
      input   : in  std_logic_vector(1 downto 0);        
      count   : out std_logic_vector(3 downto 0)
      );
end DECODER;

architecture BEHAVIOUR of DECODER is
begin
  process(input)
  begin

  case input is
    when "00" => count <= "1110";
    when "01" => count <= "1101";
    when "10" => count <= "1011";
    when "11" => count <= "0111";
    when others => count <= "0000";
  end case;
  end process;

end BEHAVIOUR;