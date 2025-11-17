{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, flake-utils, ... }: let
    # overlay supplying the quickwit package
    overlay = prev: final: {
      quickwit = prev.callPackage ./packages/quickwit { };
    };
    # per-system package set
    per-system = flake-utils.lib.eachDefaultSystem (system: let
      # quickwit in the current system
      quickwit = (import nixpkgs { inherit system; overlays = [ overlay ]; }).quickwit;
    in {
      packages = { inherit quickwit; default = quickwit; };
    });
  in {
    overlays = {
      default = overlay;
    };
  } // per-system;
}

