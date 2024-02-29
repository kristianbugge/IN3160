
library ieee;
use ieee.std_logic_1164.all;

entity shift8 is 
  port ( 
    -- System Clock and Reset
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    -- Shifted data in and out
    din       : in  std_logic;   -- Data in
    dout      : out std_logic;   -- Data out
    pout      : out std_logic_vector(7 downto 0)
  );      
end shift8;

architecture BEHAVIOUR of shift8 is
  component dff is
    port ( 
    -- System Clock and Reset
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    -- Shifted data in and out
    din       : in  std_logic;   -- Data in
    dout      : out std_logic   -- Data out
    );      
  end component dff;

  signal sig : std_logic_vector(8 downto 0) := "000000000";
  begin 
  pout   <= sig(8 downto 1);
  dff1 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(0),
      dout      => sig(1)
      );
  dff2 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(1),
      dout      => sig(2)
      );
  dff3 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(2),
      dout       => sig(3)
      );
  dff4 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(3),
      dout       => sig(4)
      );
  dff5 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(4),
      dout      => sig(5)
      );
  dff6 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(5),
      dout      => sig(6)
      );
  dff7 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(6),
      dout      => sig(7)
      );
  dff8 : dff
    port map
    (
      rst_n     => rst_n,
      mclk      => mclk,
      din       => sig(7),
      dout      => sig(8)
      );
  
  sig(0) <= din;
  dout   <= sig(8);
  pout   <= sig(8 downto 1);
  

end architecture BEHAVIOUR;