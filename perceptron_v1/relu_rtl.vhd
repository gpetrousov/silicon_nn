library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ReLU_v1 is
  port(
    -- input signals
    x : in integer range -18 to 18;

    -- output signals
    y : out integer range 0 to 18
  );
end entity; 

architecture rtl of ReLU_v1 is
begin
  process (x) is
  begin
    if x > 0 then
      y <= x;
    else
      y <= 0;
    end if;
  end process;
end architecture;
