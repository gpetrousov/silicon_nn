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

package nn_io_logic_17dn16bit is

  -- sfixed type extensions
  subtype nn_io_vector is sfixed(17 downto -16);
  type nn_io_matrix is array (integer range <>) of nn_io_vector;

end package nn_io_logic_17dn16bit;
