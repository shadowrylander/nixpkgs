{ lib, fetchFromGitHub, buildGo117Module, makeWrapper, git }:

with lib; buildGo117Module rec {
	pname = "soft";
	version = "0.2.3";
	subPackages = [ "cmd/soft" ];

    src = fetchFromGitHub {
        owner = "charmbracelet";
        repo = "soft-serve";
        rev = "v${version}";
        sha256 = "sha256-IaSXkbOBuvC7BhM+rGGYMcvk6jjKVDHH+lSs3y2UM40=";
    };

    # buildGoModule
    # vendorSha256 = "sha256-Jg756VyXP7jsYznFkfIMNfp5+MPtmth1pibe3BgivmI=";

    # buildGo116Module
    # vendorSha256 = "sha256-szC2BwdH9hwoAgAsWRe2hbb8G1ILlRVzqvYtNLe0Svo=";

    # buildGo117Module
    vendorSha256 = "sha256-m5xwxs6XvmPffDX9dkkEG0/LdlDDm6Eq9CC0tVdauVI=";

    buildInputs = [ makeWrapper ];

    # Adapted From: https://gist.github.com/CMCDragonkai/9b65cbb1989913555c203f4fa9c23374
    # postFixup = ''
    #     wrapProgram $out/bin/soft --set PATH ${lib.makeBinPath [ git ]}
    # '';

	meta = {
		homepage = https://github.com/charmbracelet/soft-serve;
		description = "A tasty, self-hostable Git server for the command line";
		license = licenses.mit;
        maintainers = with maintainers; [ sylvorg ];
	};
}
