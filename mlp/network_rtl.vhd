-- nn_logic library - 8bit
package nn_io_logic_8dn8bit is new work.nn_logic
  generic map(m => 8, n => 8);
use work.nn_io_logic_8dn8bit.all;

-- nn_logic library - 17bit
package nn_io_logic_17dn16bit is new work.nn_logic
  generic map(m => 17, n => 16);
use work.nn_io_logic_17dn16bit.all;


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
    in_features_n1 : in work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features - 1 downto 0);
    in_features_n2 : in work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features - 1 downto 0);

    o_vector : out sfixed(17 downto -16);
    out_n1   : out sfixed(17 downto -16) := (others => '0');
    out_n2   : out sfixed(17 downto -16) := (others => '0');
    out_l2   : out work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features -1 downto 0) := (others => (others => '0'))
  );
end network; 

-------------- Architecture

architecture rtl of network is

  constant bias_n1    : work.nn_io_logic_8dn8bit.nn_io_vector := to_sfixed(1, 8, -8);
  constant weights_n1 : work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features -1 downto 0) := (( to_sfixed(3, 8, -8)),
                                                                      ( to_sfixed(-1, 8, -8))
                                                                     );

  constant bias_n2    : work.nn_io_logic_8dn8bit.nn_io_vector := to_sfixed(-1, 8, -8);
  constant weights_n2 : work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features -1 downto 0) := (( to_sfixed(0.5, 8, -8)),
                                                                      ( to_sfixed(-0.5, 8, -8))
                                                                     );
  signal output_n1 : sfixed(17 downto -16);
  signal output_n2 : sfixed(17 downto -16);

  signal input_l2 :  work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features -1 downto 0) := ( others => (others => '0'));
  signal output_l2 : work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features -1 downto 0) := ( others => (others => '0'));

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

  -- ==========> Layer 2
  ReLU : entity work.relu(rtl)
  port map(
  clk => clk,
  rst => rst,
  inputs => input_l2,
  outputs => output_l2);

  out_n1 <= output_n1;
  out_n2 <= output_n2;
  out_l2 <= output_l2;
  input_l2 <= ((output_n1), (output_n2));

end architecture;
