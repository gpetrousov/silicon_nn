-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity Neuron_v3_Tb is
end entity; 

architecture sim of Neuron_v3_Tb is

  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals
  signal x_tb : std_logic_vector(31 downto 0);
  signal w_tb : std_logic_vector(31 downto 0);
  signal b_tb : std_logic_vector(31 downto 0);
  signal clk : std_logic := '0';
  signal y_tb : std_logic_vector(63 downto 0);
begin

  -- Create instance of Neuron module
  DUT_neuron : entity work.Neuron_v3(rtl) port map(
    -- signal mapping
    x => x_tb,
    w => w_tb,
    b => b_tb,
    clk => clk,
    y => y_tb);

  -- Clock process
  clk_process : process is
  begin
    clk <= not clk;
    wait for clk_perd / 2;
  end process;

  -- Testbench process
  process is
  begin
    for i in 0 to 5 loop
      wait for clk_perd;
      case i is
        when 0 =>
          x_tb <= std_logic_vector(to_signed(3, x_tb'length));
          W_tb <= std_logic_vector(to_signed(3, x_tb'length));
          b_tb <= std_logic_vector(to_signed(3, x_tb'length));
        when 1 =>
          x_tb <= std_logic_vector(to_signed(100, x_tb'length));
          W_tb <= std_logic_vector(to_signed(2, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 2 =>
          x_tb <= std_logic_vector(to_signed(0, x_tb'length));
          W_tb <= std_logic_vector(to_signed(2, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 3 =>
          x_tb <= std_logic_vector(to_signed(-1, x_tb'length));
          W_tb <= std_logic_vector(to_signed(-1, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 4 =>
          x_tb <= std_logic_vector(to_signed(-100, x_tb'length));
          W_tb <= std_logic_vector(to_signed(14, x_tb'length));
          b_tb <= std_logic_vector(to_signed(-30, x_tb'length));
        when 5 =>
          x_tb <= std_logic_vector(to_signed(100, x_tb'length));
          W_tb <= std_logic_vector(to_signed(-14, x_tb'length));
          b_tb <= std_logic_vector(to_signed(0, x_tb'length));
      end case;
    end loop;
  end process;
end sim;
