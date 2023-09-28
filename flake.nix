{
  description = "You could not live with your own failure. Where did that bring you? Back to me. - Thanos";

  inputs = {
     # NixPkgs (nixos-22.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
    flake.inputs.nixpkgs.follows = "unstable";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "unstable";
    
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
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


 #     overlays = with inputs; [
 #       neovim.overlays.x86_64-linux.neovim
 #     ];

      systems.modules = with inputs; [
        nix-ld.nixosModules.nix-ld
      ];
    };
}
