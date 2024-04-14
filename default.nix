let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/976fa3369d722e76f37c77493d99829540d43845.tar.gz") {};
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) quarto MASS;
 };
 tex = (pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-small amsmath environ fontawesome5 orcidlink pdfcol tcolorbox tikzfill;
 });
 system_packages = builtins.attrValues {
  inherit (pkgs) R quarto;
 };
 in
 pkgs.stdenv.mkDerivation {
   name = "my-paper";
   src = pkgs.fetchgit {
       url = "https://github.com/artur-sannikov/my-paper/";
       branchName = "main";
       rev = "715e9f007d104c23763cebaf03782b8e80cb5445";
       sha256 = "sha256-e8Xg7nJookKoIfiJVTGoJkvCuFNTT83YZ6SK3GT2T8g=";
     };
   buildInputs = [  rpkgs tex system_packages  ];
   buildPhase =
     ''
     # Deno needs to add stuff to $HOME/.cache
     # so we give it a home to do this
     mkdir home
     export HOME=$PWD/home
     quarto add --no-prompt $src
     quarto render $PWD/template.qmd --to jss-pdf
     '';
   installPhase =
     ''
     mkdir -p $out
     cp template.pdf $out/
     '';
 }