{
  description =
    "You could not live with your own failure. Where did that bring you? Back to me. - Thanos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    #NixPkgs Unstable (nixos-unstable)
    #unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = { url = "github:cachix/devenv"; };

    stylix = { url = "github:danth/stylix"; };

  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "flowstate";
            title = "Flowstate";
          };

          namespace = "flowstate";
        };
      };
    in lib.mkFlake {
      inherit inputs;
      namespace = "flowstate";

      src = ./.;
      channels-config.allowUnfree = true;

      systems.modules = with inputs; [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        devenv.nixosModules.devenv
      ];
    };
}
