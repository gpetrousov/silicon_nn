library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Neuron_v1_Tb is
end entity; 

architecture sim of Neuron_v1_Tb is
  signal x_tb : integer range 0 to 3;
  signal w_tb : integer range 0 to 3;
  signal b_tb : integer range 0 to 9;
  signal y_tb : integer range 0 to 18;
begin

  -- Create instance of Neuron module
  i_neuron : entity work.Neuron_v1(rtl) port map(
    -- signal mapping
    x => x_tb,
    w => w_tb,
    b => b_tb,
    y => y_tb);

  -- Testbench process
  process is
  begin
    wait for 10 ns;
    x_tb <= 3;
    w_tb <= 3;
    b_tb <= 3;
  end process;

end sim;
