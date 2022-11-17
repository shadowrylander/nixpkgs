{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "c4a6f2b78a3becb792321b4ccc345d2d7713a457";
        sha256 = "0pan3xgwqz1ha2kmkpv64spqafm4jngpx0iwiai5rps8a8axcnkf";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
