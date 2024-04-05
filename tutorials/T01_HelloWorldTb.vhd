entity T01_HelloWorldTb is
end entity;

architecture sim of T01_HelloWorldTb is
begin

  process is
  begin
    -- Start of the process thread.

    report "Hello VHDL!";
    wait;

  end process;

end architecture;
