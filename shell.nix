{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.jinja2
    python3Packages.pyyaml
    pandoc
    git
  ];
}
