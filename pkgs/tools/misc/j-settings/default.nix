{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "4cc802247d82dd251cf128363c38cd5a68976d6a";
    	sha256 = "0z823angl0z5s515i34brvf6l0jv2hmlzlnmpx72pnpvw9fv58mm";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
