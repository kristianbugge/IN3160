library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DECODER_ENTITY is
  port(
      input   : in  std_logic_vector(1 downto 0);        
      count   : out std_logic_vector(3 downto 0)
      );
end DECODER_ENTITY;

