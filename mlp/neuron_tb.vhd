-- nn_logic library
package nn_io_logic is new work.nn_logic
  generic map(m => 8, n => 8);
use work.nn_io_logic.all;

-------------- Std Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;


-------------- Entity

entity neuron_tb is
end entity; 

architecture sim of neuron_tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- input signals
  signal in_features_tb : nn_io_matrix(1 downto 0);
  signal in_weights_tb  : nn_io_matrix(1 downto 0);

  -- control signals
  signal clk_tb : std_logic := '0';
  signal rst_tb : std_logic := '0';

  -- output signals
  signal outputs_tb : sfixed(17 downto -16);
begin

  DUT_neuron : entity work.neuron(rtl)
    port map(
      in_features => in_features_tb,
      in_weights  => in_weights_tb,
      clk         => clk_tb,
      rst         => rst_tb,
      output      => outputs_tb);

  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  tb_process : process is
  begin
    wait for 50 ns;
    rst_tb <= '1';
    wait for 100 ns;
    in_features_tb(0) <= to_sfixed(11.5, 8, -8);
    in_features_tb(1) <= to_sfixed(8.2, 8, -8);
    in_weights_tb(0) <= to_sfixed(3.7, 8, -8);
    in_weights_tb(1) <= to_sfixed(4.1, 8, -8);
    rst_tb <= '0';
    wait for 100 ns;
    wait;
  end process;
end sim;
