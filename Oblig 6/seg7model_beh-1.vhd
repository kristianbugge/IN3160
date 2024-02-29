library IEEE;
use IEEE.std_logic_1164.all;

architecture beh of seg7model is
  signal char : std_logic_vector(4 downto 0);
begin
  display :
  process(c,char)
  begin
    --Default verdier
    --Benytter man default verdier kan man sløyfe 
    --else i if setninger uten å få laget en latch
    --En annen fordel er at koden kan bli enklere.
    --Benytter 'Z'(høy impendans) for å vise at et display er slukket
    disp0 <= "ZZZZZ";
    disp1 <= "ZZZZZ";
    if c then
      disp1 <= char;
    else -- c_n = '0' then
      disp0 <= char;
    end if;
  end process display;


-- Eventuelt kan det være hensiktsmessig å vise bare hexadesimale tall 0-F
 
   with abcdefg(6 downto 0) select char <= 
     5X"00" when "1111110", --"0000001", --0
     5X"01" when "0110000", --"1001111", --1
     5X"02" when "1101101", --"0010010", --2
     5X"03" when "1111001", --"0000110", --3
     5X"04" when "0110011", --"1001100", --4
     5X"05" when "1011011", --"0100100", --5
     5X"06" when "1011111", --"0100000", --6
     5X"07" when "1110000", --"0001111", --7
     5X"08" when "1111111", --"0000000", --8
     5X"09" when "1110011", --"0001100", --9
     5X"0A" when "1110111", --"0001000", --A
     5X"0B" when "0011111", --"1100000", --B
     5X"0C" when "1001110", --"0110001", --C
     5X"0D" when "0111101", --"1000010", --D
     5X"0E" when "1001111", --"0110000", --E
     5X"0F" when "1000111", --"0111000", --F
     5X"10" when "0000000", -- blank
     5X"11" when "0011110", -- \|
     5X"12" when "0111100", -- |/
     --5X"13" when "1001111", -- E
     5X"14" when "0001110", -- L
     --5X"15" when "0111101", -- d
     5X"16" when "0011101", -- o
     5X"17" when "0010101", -- n
     5X"18" when "0111011", -- y
     5X"19" when "0111110", -- U
     --5X"1A" when "1110111", -- A
     5X"1B" when "0000101", -- r
     5X"1C" when "1111011", -- g
     5X"1D" when "0011100", -- u/v
     5X"1E" when "0001101", -- c
     5X"1F" when "0001111", -- t
     "XXXXX" when others;

end architecture beh;