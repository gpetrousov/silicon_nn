library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

-- Fixed point library
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity Perceptron_ff_Tb is
end entity; 

architecture sim of Perceptron_ff_Tb is
  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals to the perceptron
  signal in1_tb : sfixed(2 downto -1);
  signal in2_tb : sfixed(2 downto -1);
  signal clk_tb : std_logic := '0';
  signal y_tb : sfixed(7 downto -9);
begin

  DUT_Perceptron_ff: entity work.Perceptron_ff port map(
    in1_perc => in1_tb,
    in2_perc => in2_tb,
    clk_perc => clk_tb,
    y_perc => y_tb 
  );

  -- Clock process
  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  -- Tb process
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
