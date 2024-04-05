entity T04_HelloWorldTb is
end entity;

architecture sim of T04_HelloWorldTb is
begin

  process is
  begin
    -- Start of the process thread.
    report "Hello!";

    for i in 1 to 10 loop
      report "In the loop: " & "i=" & integer'image(i);
    end loop;

    report "Goodbye";
    wait;

  end process;

end architecture;
