entity T06_HelloWorldTb is
end entity;

architecture sim of T06_HelloWorldTb is
-- A signal is accessivle to any process within the architecture
  signal MySignal : integer := 0;
begin

  process is
    -- Variables are declared here
    variable MyVariable : integer := 0;
  begin
    -- Start of the process thread.
    report "*** Process Begin ***";

    MyVariable := MyVariable + 1;
    MySignal <= MySignal + 1; -- signal assignment

    report "MyVariable=" & integer'image(MyVariable) & ", MySignal=" & integer'image(MySignal);

    MyVariable := MyVariable + 1;
    MySignal <= MySignal + 1; -- signal assignment

    report "MyVariable=" & integer'image(MyVariable) & ", MySignal=" & integer'image(MySignal);

    report "*** Process End ***";
    wait for 10 ns;

    MyVariable := MyVariable + 1;
    MySignal <= MySignal + 1; -- signal assignment

    report "MyVariable=" & integer'image(MyVariable) & ", MySignal=" & integer'image(MySignal);

  end process;

end architecture;
