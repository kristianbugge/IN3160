library IEEE;
use IEEE.STD_LOGIC_1164.all;

architecture BEHAVIOUR of DECODER_ENTITY is
begin
  process(input)
  begin

  with input select
    count <=     "1110" when "00",
                 "1101" when "01",
                 "1011" when "10",
		 --changing 11 to display 1111
                 "1111" when "11",
                 "0000" when others;
  end process;

end BEHAVIOUR;
