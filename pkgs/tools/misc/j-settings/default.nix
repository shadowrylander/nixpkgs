{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "8965648ce0fcda8640b84ba33eec8a33a35691dd";
        sha256 = "1y9xdvs0csdbvkvbgnj4k04yvmryzb5fgr3ip24w4gq5zql53xva";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
