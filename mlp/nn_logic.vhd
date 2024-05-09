--------------------------------------------------------------------------------
-- Library for using with Artificial Neural Networks
-- Author: Ioannis Petrousov
-- Email: petrousov@gmail.com
-- Year: 2024
--------------------------------------------------------------------------------

-------------- Std Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Fixed point lib
library floatfixlib;
use floatfixlib.fixed_pkg.all;

package nn_logic is
  generic(
    -- Integer bits
    m : integer := 5;
    -- Fractional bits
    n : integer := 8);

  -- sfixed type extensions
  subtype nn_io_vector_prod is sfixed(2*m + 1 downto -n);
  subtype nn_io_vector is sfixed(m downto -n);
  type nn_io_matrix is array (integer range <>) of nn_io_vector;

end package nn_logic;
