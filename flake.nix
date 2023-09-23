{
  description = "My NixOS / nix-darwin / nixos-generators systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs:
    let
			lib = inputs.snowfall-lib.mkLib {
				# You must pass in both your flake's inputs and the root directory of
				# your flake.
				inherit inputs;
				src = ./.;
			};
		in
			lib.mkFlake { };
}
