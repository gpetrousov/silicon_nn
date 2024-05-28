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

entity network is
  generic(
    nof_in_features : integer := 2 -- To be 784
  );
  port(
   -- control ports
    clk : in std_logic;
    rst : in std_logic;

    -- I/O ports
    in_features_n1 : in nn_io_matrix(nof_in_features - 1 downto 0); -- array of sfixed(8 downto -8)
    in_features_n2 : in nn_io_matrix(nof_in_features - 1 downto 0); -- array of sfixed(8 downto -8)

    o_vector : out sfixed(17 downto -16);
    out_n1   : out sfixed(17 downto -16);
    out_n2   : out sfixed(17 downto -16)
);
end network; 

-------------- Architecture

architecture rtl of network is

  constant bias_n1    : nn_io_vector := to_sfixed(1, 8, -8);
  constant weights_n1 : nn_io_matrix(nof_in_features -1 downto 0) := (( to_sfixed(3, 8, -8)),
                                                                      ( to_sfixed(-1, 8, -8))
                                                                     );

  constant bias_n2    : nn_io_vector := to_sfixed(-1, 8, -8);
  constant weights_n2 : nn_io_matrix(nof_in_features -1 downto 0) := (( to_sfixed(0.5, 8, -8)),
                                                                      ( to_sfixed(-0.5, 8, -8))
                                                                     );
  signal output_n1 : sfixed(17 downto -16);
  signal output_n2 : sfixed(17 downto -16);
begin

  -- ==========> Layer 1
  Neuron_1 : entity work.neuron(rtl)
  port map(
    clk => clk,
    rst => rst,
    in_features => in_features_n1,
    in_weights => weights_n1,
    in_bias => bias_n1,
    output => output_n1);

  Neuron_2 : entity work.neuron(rtl)
  port map(
    clk => clk,
    rst => rst,
    in_features => in_features_n2,
    in_weights => weights_n2,
    in_bias => bias_n2,
    output => output_n2);

  out_n1 <= output_n1;
  out_n2 <= output_n2;

end architecture;
