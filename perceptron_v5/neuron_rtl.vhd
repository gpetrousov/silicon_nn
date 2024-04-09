-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

-------------- Entity

entity Neuron_v4 is
  port(
    -- input signals
    x, w, b : in sfixed(16 downto -16);

   -- clock
    clk : in std_logic;

    -- output signals
    y : out sfixed(34 downto -32)
  );
end entity; 

-------------- Architecture

architecture rtl of Neuron_v4 is
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      y <= x * w + b;
    end if;
  end process;
end architecture;
