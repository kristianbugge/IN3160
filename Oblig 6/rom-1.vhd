library ieee;
use ieee.std_logic_1164.all;

entity rom is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(9 downto 0) );
end entity rom;

architecture behavioral of rom is
  type mem is array ( 0 to 15) of std_logic_vector(9 downto 0);
  constant my_rom : mem := (
    0  => 5X"12" & 5X"11",
    1  => 5X"14" & 5X"13",
    2  => 5X"10" & 5X"14",
    3  => 5X"10" & 5X"10",
    4  => 5X"16" & 5X"15",
    5  => 5X"13" & 5X"17",
    6  => 5X"10" & 5X"10",
    7  => 5X"16" & 5X"18",
    8  => 5X"10" & 5X"19",
    9  => 5X"10" & 5X"10",
    10 => 5X"1B" & 5X"1A", 
    11 => 5X"10" & 5X"13",
    12 => 5X"10" & 5X"10", 
    13 => 5X"16" & 5X"1C",
    14 => 5X"15" & 5X"16",
    15 => 5X"10" & 5X"10");
begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(0);
       when "0001" => data <= my_rom(1);
       when "0010" => data <= my_rom(2);
       when "0011" => data <= my_rom(3);
       when "0100" => data <= my_rom(4);
       when "0101" => data <= my_rom(5);
       when "0110" => data <= my_rom(6);
       when "0111" => data <= my_rom(7);
       when "1000" => data <= my_rom(8);
       when "1001" => data <= my_rom(9);
       when "1010" => data <= my_rom(10);
       when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
       when "1101" => data <= my_rom(13);
       when "1110" => data <= my_rom(14);
       when "1111" => data <= my_rom(15);

       when others => data <= "0000000000";
	 end case;
  end process;
end architecture behavioral;
