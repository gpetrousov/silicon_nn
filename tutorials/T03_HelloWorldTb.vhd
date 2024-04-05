entity T03_HelloWorldTb is
end entity;

architecture sim of T03_HelloWorldTb is
begin

  process is
  begin
    -- Start of the process thread.
    report "Hello!";

    loop
      report "In the loop";
      exit;
    end loop;

    report "Goodbye";
    wait;

  end process;

end architecture;
