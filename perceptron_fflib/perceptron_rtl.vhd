library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

-- Fixed point library
LIBRARY ieee;
Library floatfixlib; 
use floatfixlib.fixed_pkg.all;

entity perceptron_rtl is

  port(
    -- input signals
    in1_perc : in sfixed(2 downto -1);
    in2_perc : in sfixed(2 downto -1);

    -- clock signal
    clk_perc: in std_logic := '0';

    -- output signals
    y_perc : out sfixed(7 downto -9)
  );
end entity;

architecture rtl of perceptron_rtl is
  -- component declarations
  component neuron_rtl is
    port(
      in1 : in sfixed(2 downto -1);
      in2 : in sfixed(2 downto -1);
      clk : in std_logic;
      y : out sfixed(7 downto -9)
    );
  end component;

  component sigmoid_rtl is
    port(
      -- input signals
      addr : in sfixed(7 downto -9);
      clk : in std_logic;
      -- output signals
      data_out : out sfixed(7 downto -9)
    );
  end component;

  -- Intermediary signal declarations
  signal l1: sfixed(7 downto -9);
  signal l2: sfixed(7 downto -9);

begin

  layer_1: neuron_rtl port map(
    in1 => in1_perc,
    in2 => in2_perc,
    clk => clk_perc,
    y => l1
  );

  layer_2: sigmoid_rtl port map(
    addr => l1,
    clk => clk_perc,
    data_out => l2
   );

  process(l2) is
  begin
    y_perc <= l2;
  end process;
end architecture;
