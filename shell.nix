{ sysPkgs ? import <nixpkgs> {} }:

let
	pkgs = import (sysPkgs.fetchFromGitHub {
		owner = "NixOS";
		repo = "nixpkgs";
		# most recent commit as of 11/13/23
		rev = "bb142a6838c823a2cd8235e1d0dd3641e7dcfd63";
		hash = "sha256:0nbicig1zps3sbk7krhznay73nxr049hgpwyl57qnrbb0byzq9iy";
	}) {};

in pkgs.mkShell {
	buildInputs = with pkgs; [
        yasm
        gdb
        ddd
        xterm
	];
    # need bigger fonts for ddd
    shellHook = ''
        sudo apt-get install xfonts-100dpi
    '';
}

