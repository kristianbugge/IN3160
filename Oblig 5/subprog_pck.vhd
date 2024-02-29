library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is

  function method1(indata1: std_logic_vector) return std_logic;
  function method2(indata2: unsigned) return std_logic;

  procedure my_procedure(signal mclk: in std_logic; 
                         signal par: out  unsigned(15 downto 0));
  end;
Package body subprog_pck is
  -- non visible, internal declarations

  --Method 1: parity toggle, using for, loop and variables.
  function method1(indata1: std_logic_vector) return std_logic is
    variable toggle : std_logic := '0';
  begin
    for i in indata1'range loop
      if indata1(i) = '1' then
        toggle := not toggle;
      end if;        
    end loop;
    return toggle;
  end function;
  

  -- Method: 2 parity using xor function (VHDL 2008)
  function method2(indata2: unsigned) return std_logic is
    variable xor_parity : std_logic := '0';
  begin
    xor_parity := xor(indata2);
    return xor_parity;
  end function;
  
  procedure my_procedure(signal mclk : in std_logic; 
                         signal par  : out unsigned(15 downto 0)) is
    variable i : integer := 0;
    begin
    --while i < 128 loop
      if par < x"00FF" then 
        if rising_edge(mclk) then  
          par <=  par + '1'; --to_unsigned(i, 16);
          --i := 	i + 1;
        end if;
      end if;
    --end loop;
    end;

end subprog_pck;
