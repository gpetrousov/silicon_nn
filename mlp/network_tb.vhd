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

entity network_tb is
end entity;

-------------- Architecture

architecture sim of network_tb is
  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- input signals
  signal in_features_n1_tb : nn_io_matrix(1 downto 0);
  signal in_features_n2_tb : nn_io_matrix(1 downto 0);

  -- control signals
  signal clk_tb : std_logic := '0';
  signal rst_tb : std_logic := '0';

  -- output signals
  signal output_n1_tb : sfixed(17 downto -16);
  signal output_n2_tb : sfixed(17 downto -16);

begin

  DUT_network : entity work.network(rtl)
  port map(
    clk => clk_tb,
    rst => rst_tb,

    -- I/O ports
    in_features_n1 => in_features_n1_tb,
    in_features_n2 => in_features_n2_tb,

    out_n1 => output_n1_tb,
    out_n2 => output_n2_tb);

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
    in_features_n1_tb <= ((to_sfixed(5, 8, -8)), (to_sfixed(-2, 8, -8)));
    in_features_n2_tb <= ((to_sfixed(4, 8, -8)), (to_sfixed(2, 8, -8)));
    wait;
  end process;


end architecture;
