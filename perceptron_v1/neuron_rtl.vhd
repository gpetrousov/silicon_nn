library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Neuron_v1 is
  port(
    -- input signals
    x : in integer range 0 to 3;
    w : in integer range 0 to 3;
    b : in integer range 0 to 9;

    -- output signals
    y : out integer range 0 to 18
  );
end entity; 

architecture rtl of Neuron_v1 is
begin
  process (x, w, b) is
  begin
    y <= x * w + b;
  end process;
end architecture;
