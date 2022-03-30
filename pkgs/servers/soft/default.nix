{ lib, fetchFromGitHub, buildGo116Module, git }:

with lib; buildGo116Module rec {
	pname = "soft";
	version = "0.2.3";
	subPackages = [ "cmd/soft" ];

    src = fetchFromGitHub {
        owner = "charmbracelet";
        repo = "soft-serve";
        rev = "v${version}";
        sha256 = "sha256-IaSXkbOBuvC7BhM+rGGYMcvk6jjKVDHH+lSs3y2UM40=";
    };

    vendorSha256 = "sha256-szC2BwdH9hwoAgAsWRe2hbb8G1ILlRVzqvYtNLe0Svo=";

    propagatedBuildInputs = [ git ];

	meta = {
		homepage = https://github.com/charmbracelet/soft-serve;
		description = "A tasty, self-hostable Git server for the command line";
		license = licenses.mit;
        maintainers = with maintainers; [ sylvorg ];
	};
}
