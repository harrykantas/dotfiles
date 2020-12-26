function battery-cm
  switch $argv[1]
    case enable disable
      command ideapad-cm $argv[1] acpi_call
    case '*'
      echo "Usage: battery-cm enable|disable"
  end
end
