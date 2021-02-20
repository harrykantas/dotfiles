function home-net
  switch $argv[1]
    case up connect start
      wg-quick up wg0
    case down disconnect stop
      wg-quick down wg0
  end
end
