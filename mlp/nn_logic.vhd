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

  -- Qm,n sizes
	constant m: integer := 16; --! Size of the integer part
	constant n: integer := 16; --! Size of the fractionary part

  -- sfixed type extensions
  subtype nn_io_vector_prod is sfixed(2*m + 1 downto -n);
  subtype nn_io_vector is sfixed(m downto -n);
  type nn_io_matrix is array (integer range <>) of nn_io_vector;

end package nn_logic;
