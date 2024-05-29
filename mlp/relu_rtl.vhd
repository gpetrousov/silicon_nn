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

entity relu is
  generic(
    nof_in_features : integer := 2 -- To be equal to number of neuron from previous layer
  );

  port(
    -- control ports
    clk : in std_logic;
    rst : in std_logic;

    -- input port
    inputs: in work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features - 1 downto 0);

    -- output port
    outputs : out work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features - 1 downto 0) := (others => (others => '0'))
  );
end relu; 


-------------- Architecture

architecture rtl of relu is
  type t_state is (idle, reg_inputs, compare, reg_outputs);

  signal current_state, next_state: t_state;
  signal inputs_sig : work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features -1 downto 0);
  signal filtered_inputs_sig : work.nn_io_logic_17dn16bit.nn_io_matrix(nof_in_features -1 downto 0);

begin
  main : process(clk)
    variable index : integer := 0;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        current_state <= idle;
      else
        current_state <= next_state;

        case current_state is

          when idle =>
            next_state <= reg_inputs;

          when reg_inputs =>
            inputs_sig <= inputs;
            next_state <= compare;

          when compare =>
            if index < nof_in_features then

              if inputs_sig(index) > to_sfixed(0, 17, -16) then
                filtered_inputs_sig(index) <= inputs_sig(index);
              else
                filtered_inputs_sig(index) <= to_sfixed(0, 17, -16);
              end if;
              index := index + 1;
            else
              next_state <= reg_outputs;
            end if;

          when reg_outputs =>
            report "Reg outputs state";
            outputs <= filtered_inputs_sig;
            next_state <= reg_inputs;

        end case;
      end if;
    end if;
  end process;
end architecture;
