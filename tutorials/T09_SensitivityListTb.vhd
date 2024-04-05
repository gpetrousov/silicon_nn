entity T08_HelloWorldTb is
end entity;

architecture sim of T08_HelloWorldTb is
-- A signal is accessivle to any process within the architecture
  signal CountUp   : integer := 0;
  signal CountDown : integer := 10;
begin

  process is
    -- Variables are declared here
  begin
    -- Start of the process thread.

    CountUp   <= CountUp + 1;
    CountDown <= CountDown - 1;

    wait for 10 ns;

  end process;

  process is
  begin


    wait on CountUp, CountDown;
  end process;

end architecture;
