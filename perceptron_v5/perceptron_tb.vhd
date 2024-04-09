library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity Perceptron_v2_Tb is
end entity; 

architecture sim of Perceptron_v2_Tb is
  -- clock parameters
  constant clk_perd : time := 100 ns;
  constant clk_freq : integer := 10e6; -- 10 MHz

  -- I/O signals to the perceptron
  signal x_tb : std_logic_vector(31 downto 0);
  signal w_tb : std_logic_vector(31 downto 0);
  signal b_tb : std_logic_vector(31 downto 0);
  signal clk_tb : std_logic := '0';
  signal y_tb : std_logic_vector(63 downto 0);
begin

  DUT_Perceptron_v2: entity work.Perceptron_v2 port map(
    x_perc => x_tb,
    w_perc => w_tb,
    b_perc => b_tb,
    clk => clk_tb,
    y_perc => y_tb 
  );

  -- Clock process
  clk_process : process is
  begin
    clk_tb <= not clk_tb;
    wait for clk_perd / 2;
  end process;

  -- Tb process
  process is
  begin

    -- Test for the same inputs as in PyTorch perceptron
    -- x: 0, 1, 10, 100, -1, -10, -100
    -- w: 
    for i in 0 to 6 loop
      wait for clk_perd;
      case i is
        when 0 =>
          -- expected output 3
          x_tb <= std_logic_vector(to_signed(0, x_tb'length));
          w_tb <= std_logic_vector(to_signed(3, x_tb'length));
          b_tb <= std_logic_vector(to_signed(3, x_tb'length));
        when 1 =>
          -- expected output 52
          x_tb <= std_logic_vector(to_signed(1, x_tb'length));
          w_tb <= std_logic_vector(to_signed(2, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 2 =>
          -- expected output 70
          x_tb <= std_logic_vector(to_signed(10, x_tb'length));
          w_tb <= std_logic_vector(to_signed(2, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 3 =>
          -- expected output 0
          x_tb <= std_logic_vector(to_signed(100, x_tb'length));
          w_tb <= std_logic_vector(to_signed(-1, x_tb'length));
          b_tb <= std_logic_vector(to_signed(50, x_tb'length));
        when 4 =>
          -- expected output 0
          x_tb <= std_logic_vector(to_signed(-1, x_tb'length));
          w_tb <= std_logic_vector(to_signed(14, x_tb'length));
          b_tb <= std_logic_vector(to_signed(-30, x_tb'length));
        when 5 =>
          -- expected output 140
          x_tb <= std_logic_vector(to_signed(-10, x_tb'length));
          w_tb <= std_logic_vector(to_signed(-14, x_tb'length));
          b_tb <= std_logic_vector(to_signed(0, x_tb'length));
        when 6 =>
          -- expected output 1400
          x_tb <= std_logic_vector(to_signed(-100, x_tb'length));
          w_tb <= std_logic_vector(to_signed(-14, x_tb'length));
          b_tb <= std_logic_vector(to_signed(0, x_tb'length));
      end case;
    end loop;

  end process;
end sim;
