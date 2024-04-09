-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.fixed_pkg.all;

entity Neuron_v4_Tb is
end entity; 

architecture sim of Neuron_v4_Tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal x_tb, w_tb, b_tb : sfixed(16 downto -16);
  signal clk : std_logic := '0';
  signal y_tb : sfixed(34 downto -32);
begin

  -- Create instance of Neuron module
  DUT_neuron : entity work.Neuron_v4(rtl) port map(
    -- signal mapping
    x => x_tb,
    w => w_tb,
    b => b_tb,
    y => y_tb,
    clk => clk);

  -- Clock process
  clk_process : process is
  begin
    clk <= not clk;
    wait for clk_perd / 2;
  end process;

  -- Testbench process
  process is
  begin
    for i in 0 to 5 loop
      wait for clk_perd;
      case i is
        when 0 =>
          x_tb <= to_sfixed(0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(0, b_tb'high, b_tb'low);
        when 1 =>
          x_tb <= to_sfixed(0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(-0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(0, b_tb'high, b_tb'low);
        when 2 =>
          x_tb <= to_sfixed(-0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(-0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(0, b_tb'high, b_tb'low);
        when 3 =>
          x_tb <= to_sfixed(0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(1, b_tb'high, b_tb'low);
        when 4 =>
          x_tb <= to_sfixed(0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(-1, b_tb'high, b_tb'low);
        when 5 =>
          x_tb <= to_sfixed(-0.75, x_tb'high, x_tb'low);
          w_tb <= to_sfixed(-0.24, w_tb'high, w_tb'low);
          b_tb <= to_sfixed(-1, b_tb'high, b_tb'low);
      end case;
    end loop;
  end process;
end sim;
