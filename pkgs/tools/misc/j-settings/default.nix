{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "8c17bb4d51490ac6737048ceeef6d819ea0d356a";
    	sha256 = "1z7zrzj73jkis7ykl068hiz5giag2danbybvwj9j8s8msa92mxq8";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
