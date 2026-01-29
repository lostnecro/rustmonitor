{
  pkgs,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "rustmonitor";
  version = "0.1.0";
  src = ./.;

  cargoHash = "sha256-7ZaTz8iyoEkfsX13kPCY35QviHD1hD3o8fp+6kFncCE=";

  buildInputs = with pkgs; [
    glib
    gtk4
  ];

  nativeBuildInputs = with pkgs; [
    glib
    pkg-config
  ];

  meta = with lib; {
    description = "A system monitor written in Rust";
    mainProgram = "rustmonitor"; # Ensure this matches [package] name in Cargo.toml
    platforms = platforms.linux;
  };

}
