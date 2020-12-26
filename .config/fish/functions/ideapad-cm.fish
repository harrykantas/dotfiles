function ideapad-cm
  if test -f "/usr/bin/ideapad-cm"
    command ideapad-cm $argv acpi_call
  else
    echo "ideapad-cm is not installed."
  end
end
