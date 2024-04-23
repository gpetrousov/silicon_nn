-- Libs
library ieee;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

-- Entity
entity sigmoid_lut is
  port (
         clk : in  STD_LOGIC;
         addr : in  sfixed(7 downto -9);
         data_out : out sfixed(7 downto -9)
       );
end entity;

-- ROM addresses : ROM contents
-- 11111101000101000: 00000000000011010
-- 11111110111000110: 00000000001111110
-- 11111110110110010: 00000000001111010
-- 00000000101010000: 00000000101010001

-- Architecture
architecture rtl of sigmoid_lut is
begin
  process(clk)
  begin
      if rising_edge(clk) then

        if addr = to_sfixed(-2.92188, 7, -9) then
          data_out <= to_sfixed(0.0510, 7, -9);

        elsif addr = to_sfixed(-1.11328, 7, -9) then
          data_out <= to_sfixed(0.24725, 7, -9);

        elsif addr = to_sfixed(-1.15234, 7, -9) then
          data_out <= to_sfixed(0.24006, 7, -9);

        else
          data_out <= to_sfixed(0.65964, 7, -9);
        end if;

      end if;
  end process;
end architecture rtl;
