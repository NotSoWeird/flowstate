{
  description = "You could not live with your own failure. Where did that bring you? Back to me. - Thanos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
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
    };
  in
    lib.mkFlake {
      inherit inputs;
      #package-namespace = "custom";

      src = ./.;
      channels-config.allowUnfree = true;

      snowfall.namespace = "flowstate";

 #     overlays = with inputs; [
 #       neovim.overlays.x86_64-linux.neovim
 #     ];

      systems.modules = with inputs; [
        nix-ld.nixosModules.nix-ld
      ];
    };
}
