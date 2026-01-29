{}:

pkgs.rustPlatform.buildRustPackage {
  name = "rustmonitor";
  src = ./.;
  cargoHash = pkgs.lib.fakeHash;

  buildInputs = with pkgs; [
    cargo
    rustc
    rustfmt
    clippy
    rust-rust-analyzer
    glib
  ]
}
