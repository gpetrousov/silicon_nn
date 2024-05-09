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
    n : integer := 8;
  );

  port(
   -- utility signals
    clk : in std_logic;
		rst : in std_logic;

    -- input signals
    in_features : in nn_io_matrix(nof_input_features - 1 downto 0);
    in_weights  : in nn_io_matrix(nof_input_features - 1 downto 0);

    -- output signals
    outputs : out nn_io_vector(2*m + 1 downto -n)
  );
end neuron_rtl; 

-------------- Architecture

architecture rtl of neuron_rtl is

  signal input_features_signal : nn_io_matrix(nof_in_features - 1 downto 0) := (others => (others => '0'));
  signal input_weights_signal : nn_io_matrix(nof_in_features - 1 downto 0) := (others => (others => '0'));

begin

  -- Reset process
  reset : process(clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        in_features <= (others => (otheres => '0'));
        in_weights <= (others => (otheres => '0'));
      end if;
    end if;
  end process;

  -- SoP process (Sum of Products)
  SoP : process()


end architecture;
