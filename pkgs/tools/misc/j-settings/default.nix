{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "e365c1afd04b4b64ea8baad31eea3bc5267a4e77";
    	sha256 = "1g9c52jizik7ln4qp9nsgl6cylxa1y103zi7s7qkr4qjj204j9mi";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
