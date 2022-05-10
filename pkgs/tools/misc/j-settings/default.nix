{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "cae5832a8b85a8fc1dbf08a61bdabe29ca3d0ff7";
    	sha256 = "1bbnmz5zlqw3g0jrmyk6s4asy9w1fcwclkq219w3h6vc8nqfc202";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
