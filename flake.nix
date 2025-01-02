{
    description = "Ark: Survival Evolved";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        steam-fetcher = {
            url = "github:aidalgol/nix-steam-fetcher";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, flake-utils, steam-fetcher}: {

        nixosModules = rec {
            ark_survival_evolved = import ./nixos/ark_survival_evolved.nix {inherit self steam-fetcher;};
            default = ark_survival_evolved;
        };
        overlays.default = final: prev: {
            ark_survival_evolved-unwrapped = final.callPackage ./pkgs/ark_survival_evolved {};
            ark_survival_evolved-server = final.callPackage ./pkgs/ark_survival_evolved/fhsenv.nix {};
        };
    };
}
