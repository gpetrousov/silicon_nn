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
  type t_state is (idle, reg_inputs, multiply, sum, act_func);
  signal current_state, next_state: t_state;

  signal in_features_sig : nn_io_matrix(nof_in_features -1 downto 0);
  signal in_weights_sig : nn_io_matrix(nof_in_features -1 downto 0);

  type prod_sig_matrix is array(nof_in_features -1 downto 0) of sfixed(17 downto -16);
  signal prod_sig : prod_sig_matrix := (others => (others => '0'));

  signal sum_sig : sfixed(17 downto -16);
begin

  main : process(clk) is
    variable index : integer := 0;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        current_state <= idle;
      else
        current_state <= next_state;
        case current_state is

          when idle =>
            report "Idling";
            --- ops code
            next_state <= reg_inputs;

          when reg_inputs =>
            report "Registering inputs";
            in_features_sig <= in_features;
            in_weights_sig <= in_weights;
            next_state <= multiply;

          when multiply =>
            report "Multiply state";
            if index < nof_in_features then
              prod_sig(index) <= in_features_sig(index) * in_weights_sig(index);
              index := index + 1;
              next_state <= multiply;
            else
              next_state <= sum;
              index := 0;
            end if;

          when sum =>
            report "Sum state";
            -- sum for loop
            if index < nof_in_features then
              sum_sig <= resize(sum_sig + prod_sig(index), 17, -16);
              index := index + 1;
              next_state <= sum;
            else
              next_state <= act_func;
              index :=0;
            end if;

          when act_func =>
            report "Act func state";
            -- sum for loop
            output <= to_sfixed(1, 17, -16);
            next_state <= reg_inputs;

        end case;
      end if;
    end if;
  end process;


end architecture;
