-------------- Std Libraries
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

-------------- Entity

entity neuron_rtl is
  port(
    -- input signals
    in1 : in sfixed(2 downto -1);
    in2 : in sfixed(2 downto -1);

   -- clock
    clk : in std_logic;

    -- output signals
    y : out sfixed(7 downto -9)
  );
end neuron_rtl; 

-------------- Architecture

architecture rtl of neuron_rtl is

  constant W1 : sfixed(2 downto -8) := to_sfixed(1.77, 2, -8);
  constant W2 : sfixed(2 downto -8) := to_sfixed(1.81, 2, -8);
  constant B  : sfixed(3 downto -8) := to_sfixed(-2.92, 3, -8);

begin
  process (clk) is
  begin
    if rising_edge(clk) then
      y <= W1 * in1 + W2 * in2 + B;
    end if;
  end process;
end architecture;
