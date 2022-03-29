{ lib, fetchFromGitHub, buildGoModule, git }:

with lib; buildGoModule rec {
	pname = "soft";
	version = "0.2.3";
	subPackages = [ "cmd/soft" ];

    src = fetchFromGitHub {
        owner = "charmbracelet";
        repo = "soft-serve";
        rev = "v${version}";
        sha256 = "sha256-IaSXkbOBuvC7BhM+rGGYMcvk6jjKVDHH+lSs3y2UM40=";
    };

    vendorSha256 = "sha256-Jg756VyXP7jsYznFkfIMNfp5+MPtmth1pibe3BgivmI=";

    buildInputs = [ git ];

	meta = {
		homepage = https://github.com/charmbracelet/soft-serve;
		description = "A tasty, self-hostable Git server for the command line";
		license = licenses.mit;
        maintainers = with maintainers; [ sylvorg ];
	};
}