{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "13491292a49c6a08343aa362d379edca40e5db59";
    	sha256 = "0gcfpy1d2wlh2xvl9yd54gp1dqm4prxbjd18d4wy6sk8ffmpg38z";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
