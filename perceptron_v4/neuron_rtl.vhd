-------------- Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

-------------- Entity

entity Neuron_v3 is
  generic (
    bw_i: natural := 32;
    bw_o: natural := 64
  );

  port(
    -- input signals
    x : in std_logic_vector(bw_i-1 downto 0);
    w : in std_logic_vector(bw_i-1 downto 0);
    b : in std_logic_vector(bw_i-1 downto 0);

   -- clock
    clk : in std_logic;

    -- output signals
    y : out std_logic_vector(bw_o-1 downto 0)
  );
end entity; 

-------------- Architecture

architecture rtl of Neuron_v3 is
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      y <= x * w + b;
    end if;
  end process;
end architecture;
