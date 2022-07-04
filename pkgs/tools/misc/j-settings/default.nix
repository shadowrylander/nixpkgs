{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "db8e416c08adcae488a73bd05f2a7ff91657211a";
    	sha256 = "10dhbihm3dd4f5j9ddbkn91ps2pxnq4nas9qs7x8mdk1hiqwpyhq";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
