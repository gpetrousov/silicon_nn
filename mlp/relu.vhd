-- nn_logic library - 17bit
library work;
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
  port(
    -- control ports
    clk : in std_logic;
    rst : in std_logic;

    -- input port
    inputs: in work.nn_io_logic_17dn16bit.nn_io_matrix(2 - 1 downto 0);

    -- output port
    outputs : out work.nn_io_logic_17dn16bit.nn_io_matrix(2 - 1 downto 0) := (others => (others => '0'))
  );
end relu; 


-------------- Architecture

architecture rtl of relu is
  type t_state is (idle, reg_inputs, compare, reg_outputs);

  signal current_state, next_state: t_state;
  signal inputs_sig : work.nn_io_logic_17dn16bit.nn_io_matrix(2 -1 downto 0);
  signal filtered_inputs_sig : work.nn_io_logic_17dn16bit.nn_io_matrix(2 -1 downto 0);

begin
  main : process(clk)
    variable index : integer := 0;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        current_state <= idle;
        next_state <= idle;
      else
        current_state <= next_state;

        case current_state is

          when idle =>
            report "ReLU - Current state: idle";
            next_state <= reg_inputs;

          when reg_inputs =>
            report "ReLU - Current state: reg_inputs";
            inputs_sig <= inputs;
            next_state <= compare;

          when compare =>
            report "ReLU - Current state: compare";
            if index < 2 then

              if inputs_sig(index) > to_sfixed(0, 17, -16) then
                filtered_inputs_sig(index) <= inputs_sig(index);
                report "===================> RELU : MAJOR <==================";
              else
                filtered_inputs_sig(index) <= to_sfixed(0, 17, -16);
                report "===================> RELU : MINOR <==================";
              end if;
              index := index + 1;
            else
              next_state <= reg_outputs;
            end if;

          when reg_outputs =>
            report "ReLU - Current state: reg_outputs";
            outputs <= filtered_inputs_sig;
            next_state <= idle;

        end case;
      end if;
    end if;
  end process;
end architecture;
