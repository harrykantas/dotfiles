{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask }:
  let
    mkDarwinConfiguration = hostname: nix-darwin.lib.darwinSystem {
      modules = [
        ({ pkgs, config, ... }: let
          machineConfig = import ./hosts/${hostname}.nix { inherit pkgs; };
        in {
          nixpkgs.config.allowUnfree = true;

          environment.systemPackages = machineConfig.systemPackages;

          homebrew = machineConfig.homebrew;

          services.nix-daemon.enable = true;
	  users.users.harry = {
	    home = "/Users/harry";
	  };

	  nix.extraOptions = ''
	    auto-optimise-store = true
	    experimental-features = nix-command flakes
	  '';

          programs.zsh.enable = true;
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.activationScripts.applications.text = let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
            pkgs.lib.mkForce ''
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
            '';
        })
	home-manager.darwinModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.user.harry = import ./home.nix;
	}
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "harry";
            autoMigrate = true;
          };
        }
      ];
    };
  in
  {
    darwinConfigurations."ultraviolet" = mkDarwinConfiguration "ultraviolet";
    darwinConfigurations."vertigo" = mkDarwinConfiguration "vertigo";
  };
}

