# Adapted From: https://github.com/NixOS/nixpkgs/issues/14671#issuecomment-1016376290

{ lib, fetchFromGitHub, buildGoModule }:

with lib;

let
  imports = flip concatMapStrings [
    "github.com/mholt/caddy-l4@latest"
    "github.com/abiosoft/caddy-yaml@latest"
    "github.com/caddy-dns/cloudflare@latest"
  ] (pkg: "\t\t\t_ \"${pkg}\"\n");

	main = ''
		package main

		import (
			caddycmd "github.com/caddyserver/caddy/v2/cmd"
			_ "github.com/caddyserver/caddy/v2/modules/standard"
			${imports}
		)

		func main() {
			caddycmd.Main()
		}
	'';


in buildGoModule rec {
	pname = "caddy";
	version = "2.5.1";
    runVend = true;
	subPackages = [ "cmd/caddy" ];

	src = fetchFromGitHub {
		owner = "caddyserver";
		repo = "caddy";
		rev = "v${version}";
		sha256 = "sha256-Y4GAx/8XcW7+6eXCQ6k4e/3WZ/6MkTr5za1AXp6El9o=";
	};

	vendorSha256 = "sha256-xu3klc9yb4Ws8fvXRV286IDhi/zQVN1PKCiFKb8VJBo=";

	overrideModAttrs = (_: {
		preBuild    = "echo '${main}' > cmd/caddy/main.go";
		postInstall = "cp go.sum go.mod $out/";
	});

	postPatch = ''
		echo '${main}' > cmd/caddy/main.go
	'';

	postConfigure = ''
		cp vendor/go.sum ./
		cp vendor/go.mod ./
	'';

	meta = {
		homepage = https://caddyserver.com;
		description = "Fast, cross-platform HTTP/2 web server with automatic HTTPS";
		license = licenses.asl20;
    	maintainers = with maintainers; [ Br1ght0ne ];
	};
}
