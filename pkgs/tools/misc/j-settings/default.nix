{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "9279f22acd8efd42f3b781b8dd69b396c6f26b1a";
    	sha256 = "08g3p4xvi0rb0da5s3q790ikw3xgqxgichln0q7innb72xgjr7zk";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
