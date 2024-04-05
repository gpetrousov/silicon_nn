library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ReLU_v1_Tb is
end entity; 

architecture sim of ReLU_v1_Tb is
  signal x_tb : integer range -18 to 18;
  signal y_tb : integer range 0 to 18;
begin
  -- Create instance of ReLU module
  i_ReLU : entity work.ReLU_v1(rtl) port map(
    -- signal mapping
    x => x_tb,
    y => y_tb);

  process is
  begin
    wait for 10 ns;
    x_tb <= 0;
    wait for 10 ns;
    x_tb <= 1;
    wait for 10 ns;
    x_tb <= 18;
    wait for 10 ns;
    x_tb <= -5;
  end process;
end architecture;
