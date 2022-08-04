{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "da1a702dde6ca33e842f94452bb2dcd530a2e512";
    	sha256 = "0ylkqmpnbmvr0ic4wjayz8jvif1sjs095j5l30hsiiy7lkyxq9gn";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
