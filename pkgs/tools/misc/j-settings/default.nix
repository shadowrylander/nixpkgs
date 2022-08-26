{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "20cc61b92d624763afd2db1fa8258a59b5a58bf1";
        sha256 = "01081ixjxnyhrvigz5cl4xmag8qzfhzg14a60b98lp88kpmlkv1c";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
