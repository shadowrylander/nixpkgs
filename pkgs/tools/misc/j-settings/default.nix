{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "da5a1d61d6ecc60b0f7bc864282a6cf6b3f4bd3e";
        sha256 = "1akhag3lwfqgm14r125mbzzblxbif2f2hnbcjc5254hakkzzzz58";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
