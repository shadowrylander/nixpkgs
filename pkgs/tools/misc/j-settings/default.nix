{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "dbb79a283a8e8a1f7b133b11e0c1b8f391a77dbf";
        sha256 = "1mxh3j9l3vpblnqzrfahahsnbvn2vi569c2537pmlm5azay8ngp2";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
