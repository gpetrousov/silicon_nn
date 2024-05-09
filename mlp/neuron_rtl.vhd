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

entity neuron_rtl is
  generic(
    nof_in_features : integer := 2;
    nof_out_features : integer := 1;
    m : integer := 4;
    n : integer := 8
  );

  port(
   -- utility signals
    clk : in std_logic;
		rst : in std_logic;

    -- input signals
    in_features : in nn_io_matrix(nof_in_features - 1 downto 0);
    in_weights  : in nn_io_matrix(nof_in_features - 1 downto 0);

    -- output signals
    outputs : out nn_io_vector_prod
  );
end neuron_rtl; 

-------------- Architecture

architecture rtl of neuron_rtl is
  signal in_features_sig : nn_io_matrix(nof_in_features -1 downto 0)  := (others => (others => '0'));
  signal in_weights_sig  : nn_io_matrix(nof_in_features - 1 downto 0) := (others => (others => '0'));
begin

  reset : process(clk, rst) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        in_features_sig <= in_features;
        in_weights_sig  <= in_weights;
      end if;
    end if;
  end process;

  SoP : process(in_features_sig) is
    variable sum_prod : nn_io_vector_prod;
  begin
    if rising_edge(clk) then
      product_loop: for i in 1 to nof_in_features loop
        sum_prod := sum_prod + in_features(i) * in_weights(i);
      end loop;
    end if;
    outputs <= sum_prod;
  end process;
end architecture;
