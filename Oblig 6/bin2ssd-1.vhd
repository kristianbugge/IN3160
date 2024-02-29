library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bin2ssd is
  port(
      input    : in  std_logic_vector(4 downto 0);
      output   : out std_logic_vector(6 downto 0)
      );
end bin2ssd;

architecture BEHAVIOUR of bin2ssd is
begin
  process(input)
  begin

  case input is
    when "00000" => output <= "1111110";
    when "00001" => output <= "0110000";
    when "00010" => output <= "1101101";
    when "00011" => output <= "1111001";
    when "00100" => output <= "0110011";
    when "00101" => output <= "1011011";
    when "00110" => output <= "1011111";
    when "00111" => output <= "1110000";
    when "01000" => output <= "1111111";
    when "01001" => output <= "1110011";
    when "01010" => output <= "1110111";
    when "01011" => output <= "0011111";
    when "01100" => output <= "1001110";
    when "01101" => output <= "0111101";
    when "01110" => output <= "1001111";
    when "01111" => output <= "1000111";
    when "10000" => output <= "0000000";
    when "10001" => output <= "0011110";
    when "10010" => output <= "0111100";
    when "10011" => output <= "1001111";
    when "10100" => output <= "0001110";
    when "10101" => output <= "0111101";
    when "10110" => output <= "0011101";
    when "10111" => output <= "0010101";
    when "11000" => output <= "0111011";
    when "11001" => output <= "0111110";
    when "11010" => output <= "1110111";
    when "11011" => output <= "0000101";
    when "11100" => output <= "1111011";
    when "11101" => output <= "0011100";
    when "11110" => output <= "0001101";
    when "11111" => output <= "0001111";
    when others  => output <= "0000000";
  end case;
  end process;

end BEHAVIOUR;
