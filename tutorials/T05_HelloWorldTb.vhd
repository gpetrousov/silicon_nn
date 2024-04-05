entity T05_HelloWorldTb is
end entity;

architecture sim of T05_HelloWorldTb is
begin

  process is
    -- Variables are declared here
    variable i : integer := 0;
  begin
    -- Start of the process thread.
    report "Hello!";

    while i < 10 loop
      report "In the loop: " & "i=" & integer'image(i);
      i := i + 2;
    end loop;

    report "Goodbye";
    wait;

  end process;

end architecture;
