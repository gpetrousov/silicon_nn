library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ReLU_v4_Tb is
end entity; 

architecture sim of ReLU_v4_Tb is
  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal x_tb : std_logic_vector(63 downto 0);
  signal clk_tb : std_logic := '0';
  signal y_tb : std_logic_vector(63 downto 0);
begin
  -- Create instance of ReLU module
  DUT_ReLU : entity work.ReLU_v4(rtl) port map(
    -- signal mapping
    x => x_tb,
    clk => clk_tb,
    y => y_tb);

  -- Clock process
  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  process is
  begin

    report "#=========== BEGIN! ==========#";

    for i in 0 to 5 loop
      wait for clk_perd;

      case i is
        when 0 =>
          x_tb <= std_logic_vector(to_signed(0, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
        when 1 =>
          x_tb <= std_logic_vector(to_signed(1, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
        when 2 =>
          x_tb <= std_logic_vector(to_signed(53, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
        when 3 =>
          x_tb <= std_logic_vector(to_signed(-1, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
        when 4 =>
          x_tb <= std_logic_vector(to_signed(-10, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
        when 5 =>
          x_tb <= std_logic_vector(to_signed(-100, x_tb'length));
          report "=======> x_tb=" & integer'image(to_integer(signed(x_tb)));
      end case;

    end loop;

    report "#=========== END! ==========#";

  end process;
end architecture;
