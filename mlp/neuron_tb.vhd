-------------- Std Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

-- nn_logic library
use work.nn_logic.all;


-------------- Entity

entity neuron_tb is
end entity; 

architecture sim of neuron_tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- input signals
  signal in_features_tb : nn_io_matrix(2 downto 1);
  signal in_weights_tb  : nn_io_matrix(2 downto 1);

  -- control signals
  signal clk_tb : std_logic := '0';
  signal rst_tb : std_logic := '0';

  -- output signals
  signal outputs_tb : nn_io_vector_prod;
begin

  DUT_neuron : entity work.neuron(rtl)
    port map(
      in_features => in_features_tb,
      in_weights  => in_weights_tb,
      clk         => clk_tb,
      rst         => rst_tb,
      outputs     => outputs_tb);

  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  tb_process : process is
  begin
    for i in 0 to 3 loop
      wait for clk_perd;
      case i is

        when 0 =>
          in_features_tb(1) <= to_sfixed(0, 16, -16);
          in_features_tb(2) <= to_sfixed(0, 16, -16);
          in_weights_tb(1) <= to_sfixed(1, 16, -16);
          in_weights_tb(2) <= to_sfixed(1, 16, -16);

        when 1 =>
          in_features_tb(1) <= to_sfixed(0, 16, -16);
          in_features_tb(2) <= to_sfixed(1, 16, -16);
          in_weights_tb(1) <= to_sfixed(1, 16, -16);
          in_weights_tb(2) <= to_sfixed(1, 16, -16);

        when 2 =>
          in_features_tb(1) <= to_sfixed(1, 16, -16);
          in_features_tb(2) <= to_sfixed(0, 16, -16);
          in_weights_tb(1) <= to_sfixed(1, 16, -16);
          in_weights_tb(2) <= to_sfixed(1, 16, -16);

        when 3 =>
          in_features_tb(1) <= to_sfixed(1, 16, -16);
          in_features_tb(2) <= to_sfixed(1, 16, -16);
          in_weights_tb(1) <= to_sfixed(1, 16, -16);
          in_weights_tb(2) <= to_sfixed(1, 16, -16);

      end case;
    end loop;
  end process;
end sim;
