-- nn_logic library - 8bit
package nn_io_logic_8dn8bit is new work.nn_logic
  generic map(m => 8, n => 8);
use work.nn_io_logic_8dn8bit.all;

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
    in_features : in work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features - 1 downto 0);
    in_weights  : in work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features - 1 downto 0);
    in_bias     : in work.nn_io_logic_8dn8bit.nn_io_vector;

    -- output ports
    output : out sfixed(17 downto -16)
  );
end neuron; 

-------------- Architecture

architecture rtl of neuron is
  type t_state is (idle, reg_inputs, multiply, mult_reset, sum, sum_bias, reg_outputs);
  signal current_state, next_state: t_state;

  signal in_features_sig : work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features -1 downto 0);
  signal in_weights_sig  : work.nn_io_logic_8dn8bit.nn_io_matrix(nof_in_features -1 downto 0);
  signal in_bias_sig     : work.nn_io_logic_8dn8bit.nn_io_vector;

  type prod_sig_matrix is array(nof_in_features -1 downto 0) of sfixed(17 downto -16);
  signal prod_sig : prod_sig_matrix := (others => (others => '0'));

  signal sum_sig : sfixed(17 downto -16) := (others => '0');
begin

  main : process(clk) is
    variable index : integer := 0;
    variable bias_done : std_logic := '0';
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
            in_weights_sig  <= in_weights;
            in_bias_sig     <= in_bias;
            next_state <= multiply;

          when multiply =>
            report "Multiply state";
            if index < nof_in_features then
              prod_sig(index) <= in_features_sig(index) * in_weights_sig(index);
              index := index + 1;
              next_state <= multiply;
            else
              next_state <= mult_reset;
            end if;

          when mult_reset =>
            report "Multiply reset state";
            index := 0;
            next_state <= sum;

          when sum =>
            report "Sum state";
            -- sum for loop
            if index < nof_in_features then
              sum_sig <= resize(sum_sig, 16, -16) + resize(prod_sig(index), 16, -16);
              index := index + 1;
              next_state <= sum;
            else
              next_state <= sum_bias;
            end if;

          when sum_bias =>
            report "Sum bias state";
            if bias_done = '0' then
              sum_sig <= resize(sum_sig, 16, -16) + resize(in_bias_sig, 16, -16);
              bias_done := '1';
            end if;
            index := 0;
            next_state <= reg_outputs;

          when reg_outputs =>
            report "Act func state";
            bias_done := '0';
            output <= sum_sig;
            next_state <= idle;

        end case;
      end if;
    end if;
  end process;


end architecture;
