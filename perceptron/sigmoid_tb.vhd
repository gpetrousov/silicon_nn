library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

-- Fixed point libraries
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity sigmoid_lut_Tb is
end entity; 

architecture sim of sigmoid_lut_Tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal x_tb : sfixed(7 downto -9);
  signal y_tb : sfixed(7 downto -9);

  -- Clock
  signal clk_tb : std_logic := '0';
begin

  -- Create instance of sigmoid lut module
  DUT_sigmoid_lut : entity work.sigmoid_lut(rtl)
  port map(
    -- signal mapping
    addr => x_tb,
    clk => clk_tb,
    data_out => y_tb);

  -- Clock process
  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  process is
  begin

    report "#=========== BEGIN! ==========#";

    for i in 0 to 3 loop
      wait for clk_perd;

      case i is
        when 0 =>
          x_tb <= to_sfixed(-2.92188, 7, -9);
        when 1 =>
          x_tb <= to_sfixed(-1.11328, 7, -9);
        when 2 =>
          x_tb <= to_sfixed(-1.15234, 7, -9);
        when 3 =>
          x_tb <= to_sfixed(0.6617, 7, -9);
      end case;
    end loop;
    report "#=========== END! ==========#";

  end process;
end architecture;
