library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity Perceptron_v2 is
  generic (
    bw_i: natural := 32;
    bw_o: natural := 64
  );

  port(
    -- input signals
    x_perc : in std_logic_vector(bw_i-1 downto 0);
    w_perc : in std_logic_vector(bw_i-1 downto 0);
    b_perc : in std_logic_vector(bw_i-1 downto 0);

    -- clock signal
    clk: in std_logic := '0';

    -- output signals
    y_perc : out std_logic_vector(bw_o-1 downto 0)
  );
end entity;

architecture rtl of Perceptron_v2 is
  -- component declarations
  component Neuron_v3 is
    port(
      x : in std_logic_vector(bw_i-1 downto 0);
      w : in std_logic_vector(bw_i-1 downto 0);
      b : in std_logic_vector(bw_i-1 downto 0);
      clk : in std_logic;
      y : out std_logic_vector(bw_o-1 downto 0)
    );
  end component;

  component ReLU_v4 is
    port(
      -- input signals
      x : in std_logic_vector(bw_o-1 downto 0);
      clk : in std_logic;
      -- output signals
      y : out std_logic_vector(bw_o-1 downto 0)
    );
  end component;

  -- Intermediary signal declarations
  signal l1: std_logic_vector(bw_o-1 downto 0);
  signal l2: std_logic_vector(bw_o-1 downto 0);
  signal clk_tb : std_logic := '0';

begin

  layer_1: Neuron_v3 port map(
    x => x_perc,
    w => w_perc,
    b => b_perc,
    clk => clk,
    y => l1
  );

  layer_2: ReLU_v4 port map(
    x => l1,
    clk => clk,
    y => l2
   );

  process(l2) is
  begin
    y_perc <= l2;
  end process;
end architecture;
