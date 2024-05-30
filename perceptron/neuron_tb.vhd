-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point library
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity Neuron_ff_Tb is
end entity; 

architecture sim of Neuron_ff_Tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal in1_tb : sfixed(2 downto -1);
  signal in2_tb : sfixed(2 downto -1);

  -- Clock
  signal clk : std_logic := '0';

  -- Output
  signal y_tb : sfixed(7 downto -9);
begin

  -- Create instance of Neuron module
  DUT_neuron : entity work.Neuron_ff(rtl)
    port map(
      -- signal mapping
      in1 => in1_tb,
      in2 => in2_tb,
      clk => clk,
      y => y_tb);

  -- Clock process
  clk_process : process is
  begin
    clk <= not clk;
    wait for clk_perd / 2;
  end process;

  -- Testbench process
  process is
  begin
    for i in 0 to 3 loop
      wait for clk_perd;
      case i is
        when 0 =>
          in1_tb <= to_sfixed(0, 2, -1);
          in2_tb <= to_sfixed(0, 2, -1);
        when 1 =>
          in1_tb <= to_sfixed(0, 2, -1);
          in2_tb <= to_sfixed(1, 2, -1);
        when 2 =>
          in1_tb <= to_sfixed(1, 2, -1);
          in2_tb <= to_sfixed(0, 2, -1);
        when 3 =>
          in1_tb <= to_sfixed(1, 2, -1);
          in2_tb <= to_sfixed(1, 2, -1);
      end case;
    end loop;
  end process;
end sim;
