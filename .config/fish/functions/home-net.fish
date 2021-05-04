function home-net
  switch $argv[1]
    case up connect start
      sudo wg-quick up wg0
    case down disconnect stop
      sudo wg-quick down wg0
    case restart reset
      sudo wg-quick down wg0
      sudo wg-quick up wg0
    case status show
      if test (ip link | grep -c wg0) -eq 0
        echo "Interface wg0 is not up."
      else
        sudo wg show
      end
  end
end
