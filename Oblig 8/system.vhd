library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.numeric_std.all;
  use STD.textio.all;

entity system is 
  port
  (
  mclk       : in std_logic;
  reset      : in std_logic;
  sa         : in std_logic;
  sb         : in std_logic;
  dir_synch  : out std_logic;
  en_synch   : out std_logic;
  abcdefg    : out std_logic_vector(6 downto 0);
  c          : out std_logic
  );
end entity system;

architecture arch of system is
component self_test_module is
  port
  (
  mclk       : in std_logic;
  reset      : in std_logic;
  duty_cycle : out std_logic_vector(7 downto 0)
  );
end component self_test_module;

component pulse_width_modulator is
  port(
  mclk       : in std_logic;
  reset      : in std_logic;
  duty_cycle : in std_logic_vector(7 downto 0);
  dir        : out std_logic;
  en         : out std_logic
  );
end component pulse_width_modulator;

component output_synchronizer is 
  port
  (
  mclk      : in std_logic;
  reset     : in std_logic;
  dir       : in std_logic;
  en        : in std_logic;
  dir_synch : out std_logic;
  en_synch  : out std_logic
  );
end component output_synchronizer;

component input_synchronizer is 
  port
  (
  mclk      : in std_logic;
  reset     : in std_logic;
  sa        : in std_logic;
  sb        : in std_logic;
  sa_synch  : out std_logic;
  sb_synch  : out std_logic
  );
end component input_synchronizer;

component quadrature_decoder is 
  port
  (
  mclk       : in std_logic;
  reset      : in std_logic;
  sa         : in std_logic;
  sb         : in std_logic;
  pos_inc    : out std_logic;
  pos_dec    : out std_logic
  );
end component quadrature_decoder;

component velocity_reader is
  generic(
    -- these are made generics for the purpose of testing with a lower clock frequency:
    RCOUNT_WIDTH : natural := 20; -- width of clock dividing down to 100Hz; -- 20 bit should be enough for 100MHz / 10^6 = 100Hz
    TEN_MS_COUNT : natural := 1_000_000 -- number of cycles until 10 ms is reached at 100MHz
  );
  port(
    mclk      : in std_logic; 
    reset     : in std_logic; 
    pos_inc   : in std_logic;
    pos_dec   : in std_logic;
    velocity  : out signed(7 downto 0) -- rpm value updated every 1/100 s 
  );
end component velocity_reader;

component seg7ctrl is
  port
  (
    mclk    : in std_logic; -- 100MHz, positive flank
    reset   : in std_logic; -- Asynchronous reset, active high
    d0      : in std_logic_vector(3 downto 0);
    d1      : in std_logic_vector(3 downto 0);
    abcdefg : out std_logic_vector(6 downto 0);
    c       : out std_logic := '0'
  );
end component seg7ctrl;

signal con_duty_cycle  : std_logic_vector(7 downto 0);
signal con_dir         : std_logic;
signal con_en          : std_logic;
signal con_sa_synch    : std_logic;
signal con_sb_synch    : std_logic;
signal con_pos_inc     : std_logic;
signal con_pos_dec     : std_logic;
signal velocity        : signed(7 downto 0);
signal fart            : signed(7 downto 0);
begin

UUT1: entity work.self_test_module(arch)
    port map
      (
      mclk => mclk,
      reset => reset,
      duty_cycle => con_duty_cycle
      );
UUT2: entity work.pulse_width_modulator(asm)
    port map
      (
      mclk => mclk,
      reset => reset,
      duty_cycle => con_duty_cycle,
      dir => con_dir,
      en => con_en
      );
UUT3: entity work.output_synchronizer(arch)
    port map
      (
      mclk => mclk,
      reset => reset,
      dir => con_dir,
      en => con_en,
      dir_synch => dir_synch,
      en_synch => en_synch
      );
UUT4: entity work.input_synchronizer(arch)
    port map
      (
      mclk => mclk,
      reset => reset,
      sa => sa,
      sb => sb,
      sa_synch => con_sa_synch,
      sb_synch => con_sb_synch
      );
UUT5: entity work.quadrature_decoder(arch)
    port map
      (
      mclk => mclk,
      reset => reset,
      sa => con_sa_synch,
      sb => con_sb_synch,
      pos_inc => con_pos_inc,
      pos_dec => con_pos_dec
      );
UUT6: entity work.velocity_reader(rtl)
    port map
      (
      mclk => mclk,
      reset => reset,
      pos_inc => con_pos_inc,
      pos_dec => con_pos_dec,
      velocity=> velocity
      );
fart <= abs(velocity);
UUT7: entity work.seg7ctrl(str)
    port map
      (
      mclk => mclk,
      reset => reset,
      d0 => std_logic_vector(fart(3 downto 0)),
      d1 => std_logic_vector(fart(7 downto 4)),
      abcdefg => abcdefg,
      c => c
      );
end architecture arch;