-- nn_logic library
package nn_io_logic is new work.nn_logic
  generic map(m => 17, n => 16);
use work.nn_io_logic.all;

-------------- Std Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;


-------------- Entity

entity relu_tb is
end entity; 

architecture sim of relu_tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- input signals
  signal inputs_tb : nn_io_matrix(1 downto 0);

  -- control signals
  signal clk_tb : std_logic := '0';
  signal rst_tb : std_logic := '0';

  -- output signals
  signal outputs_tb : nn_io_matrix(1 downto 0);
begin

  DUT_relu : entity work.relu(rtl)
    port map(
      inputs => inputs_tb,
      clk    => clk_tb,
      rst    => rst_tb,
      outputs => outputs_tb);

  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  tb_process : process is
  begin
    wait for 30 ns;
    rst_tb <= '1';
    wait for 30 ns;
    rst_tb <= '0';
    wait for 30 ns;
    inputs_tb(0) <= to_sfixed(5.2, 17, -16);
    inputs_tb(1) <= to_sfixed(-1.5, 17, -16);
    wait;
  end process;
end sim;
