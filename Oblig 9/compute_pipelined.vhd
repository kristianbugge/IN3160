library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compute_pipelined is
  port
	(rst	: in  std_logic;
 	clk	: in  std_logic;
 	a  	: in  std_logic_vector(15 downto 0);
 	b  	: in  std_logic_vector(15 downto 0);
 	c  	: in  std_logic_vector(15 downto 0);
 	d  	: in  std_logic_vector(15 downto 0);
 	e  	: in  std_logic_vector(15 downto 0);
 	dvalid  : in  std_logic;
 	result  : out std_logic_vector(31 downto 0);	 
 	max	: out std_logic;
 	rvalid  : out std_logic);
end entity compute_pipelined;

architecture RTL of compute_pipelined is
  signal r_dvalid, next_max, overflow : std_logic;
  signal r_abcd, next_abcd : unsigned(17 downto 0);
  signal next_result : unsigned(31 downto 0);
  signal r_abcde, next_abcde : unsigned(33 downto 0);
  signal r_e : unsigned(15 downto 0);
begin
  REG_ASSIGNMENT: process(clk) is
  begin
    if rising_edge(clk) then
      if rst then
        r_dvalid <= '0';
        r_abcd <= (others => '0');
    	r_abcde <= (others => '0');
    	result <= (others => '0'); 	 
    	r_e <= (others => '0');
      else
    	r_e <= unsigned(e);
    	r_dvalid <= dvalid;
    	max <= next_max;
    	r_abcd <= next_abcd;
    	r_abcde <= next_abcde;
    	rvalid <= r_dvalid;
    	result <= std_logic_vector(next_result);
      end if;
    end if;
  end process;

next_abcd <= (unsigned("00" & a) + unsigned("00" & b)) +
         	(unsigned("00" & c) + unsigned("00" & d));
next_abcde <= r_abcd * r_e;
overflow <= or next_abcde(33 downto 32);

next_result <=  (others => '1') when overflow = '1' else 
next_abcde(31 downto 0) when r_dvalid = '1' else
(others => '0') when r_dvalid = '0';

next_max <= '0' when r_dvalid = '0' else overflow when r_dvalid='1' else '0';

end architecture RTL;
