{ lib, fetchFromGitHub, buildGoModule, makeWrapper, git }:

with lib; buildGoModule rec {
	pname = "soft";
	version = "0.3.0";
	subPackages = [ "cmd/soft" ];

    src = fetchFromGitHub {
        owner = "charmbracelet";
        repo = "soft-serve";
        rev = "v${version}";
        sha256 = "sha256-FtWlE2CmUx9ric4yFItj7lc57259/BVINyUhSuBNapo=";
    };

    vendorSha256 = "sha256-MwbtrtfvQ1HimLjUCmk8Twr4tpfP4eFBUlDP15IZKto=";

    buildInputs = [ makeWrapper ];

	meta = {
		homepage = https://github.com/charmbracelet/soft-serve;
		description = "A tasty, self-hostable Git server for the command line";
		license = licenses.mit;
        maintainers = with maintainers; [ sylvorg ];
	};
}
