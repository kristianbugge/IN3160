library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;
entity pulse_width_modulator is
  port(
  mclk       : in std_logic;
  reset      : in std_logic;
  duty_cycle : in std_logic_vector(7 downto 0);
  dir        : out std_logic;
  en         : out std_logic
  );
end entity pulse_width_modulator;

architecture asm of pulse_width_modulator is
  type state_type is (forward_idle, reverse_idle, forward, reverse);
  signal present_state, next_state : state_type;

  signal pwm       : std_logic := '0';
  signal pwm_count : unsigned(14 downto 0) := (others => '0');

  begin
  
  present_state <= reverse_idle when reset else next_state when rising_edge(mclk);
 
  next_state_CL: process(duty_cycle, mclk, reset) is
  begin
    case present_state is
    when reverse_idle =>
      next_state <=
      reverse_idle when reset else
      forward_idle when duty_cycle(7) = '0' else
      reverse when duty_cycle(7) = '1' else
      reverse_idle;
    when forward_idle =>
      next_state <=
      reverse_idle when reset else
      reverse_idle when duty_cycle(7) = '1' else
      forward when duty_cycle(7) = '0' else
      forward_idle;
    when reverse =>
      next_state <=
      reverse_idle when reset else
      reverse_idle when duty_cycle(7) = '0' else
      reverse;
    when forward =>
      next_state <=
      reverse_idle when reset else
      forward_idle when duty_cycle(7) = '1' else
      forward;
    end case;
  end process next_state_CL;

      
  output_cl: process(all) is 
  variable magnitude : unsigned(7 downto 0);
  begin
    magnitude := unsigned(abs(signed(duty_cycle)));
  
    if reset = '1' then
      pwm_count <= (others => '0');
      pwm <= '0';
    elsif rising_edge(mclk) then
    pwm_count <= pwm_count + 1;
      if magnitude(6 downto 0) > pwm_count(14 downto 8) then
        pwm <= '1';
      else
        pwm <= '0';
      end if;
    end if;
    case present_state is
      when reverse_idle =>
        en  <= '0';
        dir <= '0';
      when reverse =>
        en  <= pwm;
        dir <= '0';
      when forward_idle =>
        en  <= '0';
        dir <= '1';
      when forward =>
        en  <= pwm;
        dir <= '1';
    end case;
  end process;
end architecture asm;