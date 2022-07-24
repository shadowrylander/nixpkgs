{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "1de7d105133acc14ebef2ef6e90e6df67ca4cf24";
    	sha256 = "1jqki7l4wxysr1019cy1l5wxasqzcnj1qlklcx11lqc6i9r2f4lv";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
