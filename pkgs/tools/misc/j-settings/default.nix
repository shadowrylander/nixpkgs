{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "f9342829e278e7595b75cff5f6337659049a20aa";
        sha256 = "0pf3r38g62lqvfy2kc9rjxkicjfmyqcgc14pv6bwbljzgs1yxhmd";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
