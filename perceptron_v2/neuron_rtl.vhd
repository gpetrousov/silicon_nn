library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity Neuron_v2 is
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

architecture rtl of Neuron_v2 is
begin
  process (x, w, b) is
  begin
    y <= x * w + b;
  end process;
end architecture;
