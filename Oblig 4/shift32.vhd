
library ieee;
use ieee.std_logic_1164.all;

entity shift32 is 
  port ( 
    -- System Clock and Reset
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    -- Shifted data in and out
    din       : in  std_logic;   -- Data in
    dout      : out std_logic;   -- Data out
    pout      : out std_logic_vector(31 downto 0)
  );      
end shift32;

architecture BEHAVIOUR of shift32 is
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
  
  signal sig : std_logic_vector(32 downto 0);
  begin 
  

	lokke: for i in 0 to 31 generate komponent: dff
	port map(
		rst_n     => rst_n,
                mclk      => mclk,
                din       => sig(i),
                dout      => sig(i + 1)
		);
	end generate;

	sig(0) <= din;
        dout   <= sig(32);
        pout   <= sig(32 downto 1);

end architecture BEHAVIOUR;
