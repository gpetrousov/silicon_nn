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

entity neuron is
  generic(
    nof_in_features : integer := 2 -- To be 784
  );

  port(
   -- control ports
    clk : in std_logic;
    rst : in std_logic;

    -- input ports
    in_features : in nn_io_matrix(nof_in_features - 1 downto 0);
    in_weights  : in nn_io_matrix(nof_in_features - 1 downto 0);

    -- output ports
    output : out sfixed(17 downto -16)
  );
end neuron; 

-------------- Architecture

architecture rtl of neuron is
  type prod_sig_matrix is array(nof_in_features -1 downto 0) of sfixed(17 downto -16);
  subtype sum_sig_vector is sfixed(17 downto -16);

  signal in_features_sig : nn_io_matrix(nof_in_features - 1 downto 0)  := in_features;
  signal in_weights_sig  : nn_io_matrix(nof_in_features - 1 downto 0)  := in_weights;

  signal prod_sig        : prod_sig_matrix                             := (others => (others =>'0'));
  signal sum_sig         : sum_sig_vector                              := (others => '0');
begin

  process(clk) is

  begin
    if rising_edge(clk) then

      -- MAC here
      for i in 0 to nof_in_features-1 loop
        report "Multiply Loop : " & "i=" & integer'image(i);
        prod_sig(i) <= in_features_sig(i) * in_weights_sig(i);
      end loop;

      for j in 0 to nof_in_features-1 loop
        report "Sum Loop: " & "i=" & integer'image(j);
        sum_sig <= resize(sum_sig + prod_sig(j), 17, -16);
      end loop;

    end if;
  end process;

  -- Output from entity
  output <= sum_sig;
end architecture;
