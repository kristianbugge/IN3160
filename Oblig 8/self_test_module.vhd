library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;

entity self_test_module is 
  port
  (
  mclk       : in std_logic;
  reset      : in std_logic;
  duty_cycle : out std_logic_vector(7 downto 0)
  );
end entity self_test_module;

architecture arch of self_test_module is 
  component rom is
    generic(
      data_width: natural := 8;
      addr_width: natural := 5;
      filename: string := "ROM_data_bits.txt"
    );
    port(
      address: in std_logic_vector(addr_width-1 downto 0);
      data: out std_logic_vector(data_width-1 downto 0)
    );
  end component rom;
  signal count : unsigned(28 downto 0):= (others => '0');
  signal maxcount : unsigned(28 downto 0):= "10001111000011010001100000000";
  signal second_tick : std_logic := '0';
  signal address : std_logic_vector(4 downto 0) := "00000";
  signal data    : std_logic_vector(7 downto 0);
  begin
  
  UUT0: entity work.rom(behavioral)
    port map
      (
      address => address,
      data => data
      );
  
  process(mclk, reset)
  begin
    if reset = '1' then 
      address <= "00000";
      second_tick <= '0';
      count <= (others => '0');

    elsif rising_edge(mclk) then 
      count <= count + 1;

      if count = maxcount then
        count <= (others => '0');
        second_tick <= '1';   
        address <= std_logic_vector(unsigned(address) + 1);
        duty_cycle <= data;
      else
        second_tick <= '0';
      end if;
    end if;
  end process;
end architecture arch;