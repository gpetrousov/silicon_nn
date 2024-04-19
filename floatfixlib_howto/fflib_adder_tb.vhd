-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point library
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity adder_tb is
end entity; 

architecture sim of adder_tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal in1_tb : sfixed(2 downto -8);
  signal in2_tb : sfixed(2 downto -8);

  -- Clock
  signal clk : std_logic := '0';

  -- Output
  signal y_tb : sfixed(3 downto -8);
begin

  -- Create instance of Neuron module
  DUT_adder : entity work.adder(rtl)
    port map(
      -- signal mapping
      data1 => in1_tb,
      data2 => in2_tb,
      clk => clk,
      sum => y_tb);

  -- Clock process
  clk_process : process is
  begin
    clk <= not clk;
    wait for clk_perd / 2;
  end process;

  -- Testbench process
  process is
  begin
      wait for clk_perd;
      in1_tb <= to_sfixed(1.77, 2, -8);
      in2_tb <= to_sfixed(1.81, 2, -8);
      wait for clk_perd;
      in1_tb <= to_sfixed(-1.77, 2, -8);
      in2_tb <= to_sfixed(1.81, 2, -8);
      wait for clk_perd;
      in1_tb <= to_sfixed(1.77, 2, -8);
      in2_tb <= to_sfixed(-1.81, 2, -8);
  end process;
end sim;
