{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "0fd8fb83fd1e3c5029de4c735809b6f6e173e6bb";
        sha256 = "1r7jp60q471b3723lxffjpgdahg5i8mycvw1g90gm8xdhsf9nfra";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
