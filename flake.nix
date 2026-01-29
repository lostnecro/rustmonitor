{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };

      rustToolchain = pkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
      };

      rustPlatform = pkgs.makeRustPlatform {
        cargo = rustToolchain;
        rustc = rustToolchain;
      };
    in
    {
      # The actual package build
      packages.${system}.default = pkgs.callPackage ./default.nix {
        inherit rustPlatform;
      };

      # The development environment (nix develop)
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = [
          rustToolchain
          pkgs.pkg-config
        ];

        buildInputs = with pkgs; [
          glib
          gtk4
        ];

        shellHook = ''
          clear
          export RUST_BACKTRACE=1
          export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
          if [ -n "$(git status --porcelain)" ]; then
                      echo -e "\e[1;33m⚠️  Warning: Git tree is dirty. Remember to 'git add' new files!\e[0m"
                    fi
          echo "📦 GLib version: $(pkg-config --modversion glib-2.0)"
          echo "🦀 Oxalica Rust ${rustToolchain.version} loaded!"
          echo "🦀 Rust development shell loaded!"
        '';
      };
    };
}
