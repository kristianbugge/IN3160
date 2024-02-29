library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;

entity quadrature_decoder is 
  port
  (
  mclk       : in std_logic;
  reset      : in std_logic;
  sa         : in std_logic;
  sb         : in std_logic;
  pos_inc    : out std_logic;
  pos_dec    : out std_logic
  );
end entity quadrature_decoder;
architecture arch of quadrature_decoder is
  type state_type is (S_reset, S_init, S_0, S_1, S_2, S_3);
  signal present_state, next_state : state_type;
  signal err : std_logic;
  signal ab  : std_logic_vector(1 downto 0);
  begin
  
  present_state <= S_reset when reset else next_state when rising_edge(mclk);

  next_state_CL: process(mclk, reset, present_state) is
  begin
    
    case present_state is
    when S_reset =>
      next_state <=
      S_init;
    when S_init =>
      next_state <=
      S_2 when sa and sb else
      S_3 when sa and not  sb else
      S_1 when not sa and sb else 
      S_0 when not sa and not sb else 
      S_reset;
    when S_0 =>
      next_state <=
      S_2 when sa and sb else
      S_3 when sa and not sb else
      S_1 when not sa and sb else 
      S_0 when not sa and not sb else 
      S_reset;
    when S_1 =>
      next_state <=
      S_2 when sa and sb else
      S_3 when sa and not sb else
      S_1 when not sa and sb else 
      S_0 when not sa and not sb else 
      S_reset;
    when S_2 =>
      next_state <=
      S_2 when sa and sb else
      S_3 when sa and not sb else
      S_1 when not sa and sb else 
      S_0 when not sa and not sb else 
      S_reset;
    when S_3 =>
      next_state <=
      S_2 when sa and sb else
      S_3 when sa and not sb else
      S_1 when not sa and sb else 
      S_0 when not sa and not sb else 
      S_reset;
    end case;

  end process next_state_CL;

  output_cl: process(all) is 
  begin
    ab(1) <= sa;
    ab(0) <= sb;
    if reset = '1' then
      err <= '0';
      pos_inc <= '0';
      pos_dec <= '0';
    end if;
    case present_state is
      when S_reset =>
	err <= '0';
        pos_inc <= '0';
        pos_dec <= '0';

      when S_init =>
        err <= '0';
        pos_inc <= '0';
        pos_dec <= '0';

      when S_0 =>

      case ab is
	when "00" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';
	when "01" =>
	  err <= '0';
          pos_inc <= '1';
          pos_dec <= '0';
	when "10" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '1';
	when "11" =>
	  err <= '1';
          pos_inc <= '0';
          pos_dec <= '0';
	when others =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';  
      end case;

      when S_1 =>
      case ab is
	when "00" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '1';
	when "01" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';
	when "10" =>
	  err <= '1';
          pos_inc <= '0';
          pos_dec <= '0';
	when "11" =>
	  err <= '0';
          pos_inc <= '1';
          pos_dec <= '0';
	when others =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';  
      end case;
      when S_2 =>
      case ab is
	when "00" =>
	  err <= '1';
          pos_inc <= '0';
          pos_dec <= '0';
	when "01" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '1';
	when "10" =>
	  err <= '0';
          pos_inc <= '1';
          pos_dec <= '0';
	when "11" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';
	when others =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';  
      end case;
      when S_3 =>
      case ab is
	when "00" =>
	  err <= '0';
          pos_inc <= '1';
          pos_dec <= '0';
	when "01" =>
	  err <= '1';
          pos_inc <= '0';
          pos_dec <= '0';
	when "10" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';
	when "11" =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '1';
	when others =>
	  err <= '0';
          pos_inc <= '0';
          pos_dec <= '0';  
      end case;
    end case;
  end process;
end architecture arch;