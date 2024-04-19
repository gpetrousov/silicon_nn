library ieee;
use ieee.std_logic_1164.all;

-- Fixed point library
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity adder is
  port (
    clk : in  std_logic;
    data1 : in  sfixed(2 downto -8);  -- Signed fixed-point input (8 bits total, 8 fractional bits)
    data2 : in  sfixed(2 downto -8);  -- Signed fixed-point input (8 bits total, 8 fractional bits)
    sum : out  sfixed(3 downto -8)   -- Signed fixed-point output (9 bits total, 8 fractional bits)
  );
end entity adder ;

architecture rtl of adder is

begin

  process(clk)
  begin
    if rising_edge(clk) then
      sum <= data1 + data2;  -- Perform fixed-point addition
    end if;
  end process;

end architecture rtl;
