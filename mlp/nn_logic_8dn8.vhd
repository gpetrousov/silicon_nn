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

package nn_logic_8dn8 is

  -- sfixed type extensions
  subtype nn_io_vector_8dn8 is sfixed(8 downto -8);
  type nn_io_matrix is array (integer range <>) of nn_io_vector_8dn8;

end package nn_logic_8dn8;
