--------------------------------------------------------------------------------
-- Library for using with Artificial Neural Networks
-- Author: Ioannis Petrousov
-- Email: petrousov@gmail.com
-- Year: 2024
--------------------------------------------------------------------------------

-------------- Std Libraries
library ieee;
use ieee.numeric_std.all;

-- Fixed point lib
library floatfixlib;
use floatfixlib.fixed_pkg.all;

package nn_logic is
  generic(
    m : integer := 8;
    n : integer := 8
  );

  -- sfixed type extensions
  subtype nn_io_vector is sfixed(m downto -n);
  type nn_io_matrix is array (integer range <>) of nn_io_vector;

end package nn_logic;
