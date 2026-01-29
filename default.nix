{
  pkgs,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "rustmonitor";
  version = "0.1.0";
  src = ./.;

  cargoHash = "sha256-HvDQ7XSbZ14JNoL1bGDNp5yyAw0/B/Rf91aCOhNVQ4s=";

  buildInputs = with pkgs; [
    glib
  ];

  nativeBuildInputs = with pkgs; [
    glib
  ];

  meta = with lib; {
    description = "A system monitor written in Rust";
    mainProgram = "rustmonitor"; # Ensure this matches [package] name in Cargo.toml
    platforms = platforms.linux;
  };

}
