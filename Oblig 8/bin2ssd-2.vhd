library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bin2ssd is
  port(
      input    : in  std_logic_vector(3 downto 0);
      output   : out std_logic_vector(6 downto 0)
      );
end bin2ssd;

architecture BEHAVIOUR of bin2ssd is
begin
  process(input)
  begin

  case input is
    when "0000" => output <= "1111110";
    when "0001" => output <= "0110000";
    when "0010" => output <= "1101101";
    when "0011" => output <= "1111001";
    when "0100" => output <= "0110011";
    when "0101" => output <= "1011011";
    when "0110" => output <= "1011111";
    when "0111" => output <= "1110000";
    when "1000" => output <= "1111111";
    when "1001" => output <= "1110011";
    when "1010" => output <= "1110111";
    when "1011" => output <= "0011111";
    when "1100" => output <= "1001110";
    when "1101" => output <= "0111101";
    when "1110" => output <= "1001111";
    when "1111" => output <= "1000111";
    when others => output <= "0000000";
  end case;
  end process;

end BEHAVIOUR;
