library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity Perceptron_v1 is
  generic (
    bw_i: natural := 32;
    bw_o: natural := 64
  );

  port(
    -- input signals
    x : in std_logic_vector(bw_i-1 downto 0);
    w : in std_logic_vector(bw_i-1 downto 0);
    b : in std_logic_vector(bw_i-1 downto 0);

    -- output signals
    y : out std_logic_vector(bw_o-1 downto 0)
  );
end entity; 

architecture rtl of Perceptron_v1 is
  -- componenet declarations
  component Neuron_v2 is
    port(
      x : in std_logic_vector(bw_i-1 downto 0);
      w : in std_logic_vector(bw_i-1 downto 0);
      b : in std_logic_vector(bw_i-1 downto 0);
      y : out std_logic_vector(bw_o-1 downto 0)
    );
  end component;

  component ReLU_v3 is
    port(
      -- input signals
      x : in std_logic_vector(bw_o-1 downto 0);
      -- output signals
      y : out std_logic_vector(bw_o-1 downto 0)
    );
  end component;

  -- Intermediary signal declarations
  signal l1: std_logic_vector(bw_o-1 downto 0);
  signal l2: std_logic_vector(bw_o-1 downto 0);

begin

  layer_1: Neuron_v2 port map(
    x => x,
    w => w,
    b => b,
    y => l1
  );

  layer_2: ReLU_v3 port map(
    x => l1,
    y => l2
   );

  process (x, w, b) is
  begin

    y <= l2;

  end process;
end architecture;
