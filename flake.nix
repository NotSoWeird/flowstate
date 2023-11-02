{
  description = "You could not live with your own failure. Where did that bring you? Back to me. - Thanos";

  inputs = {
     # NixPkgs (nixos-22.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixPkgs Unstable (nixos-unstable)
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake";
    flake.inputs.nixpkgs.follows = "nixpkgs";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "nixpkgs";
    
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    neovim = {
#      url = github:IogaMaster/neovim;
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

  outputs = inputs: let
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
  in
    lib.mkFlake {
      inherit inputs;
      namespace = "flowstate";

      src = ./.;
      channels-config.allowUnfree = true;

      # overlays = with inputs; [
      #   stylix
      # ];

      systems.modules = with inputs; [
        home-manager.nixosModules.home-manager
        nix-ld.nixosModules.nix-ld
      ];
    };
}
