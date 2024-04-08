library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ReLU_v4 is
  generic (
    bw : natural := 64
  );

  port(
    -- input signals
    x : in std_logic_vector(bw-1 downto 0);

    -- clock
    clk: in std_logic;

    -- output signals
    y : out std_logic_vector(bw-1 downto 0)
  );

end entity; 

architecture rtl of ReLU_v4 is
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      -- TODO: how does if translate to gates?
      if x > "0000000000000000000000000000000000000000000000000000000000000000" then
        y <= x;
      else
        y <= "0000000000000000000000000000000000000000000000000000000000000000";
      end if;
    end if;
  end process;
end architecture;
