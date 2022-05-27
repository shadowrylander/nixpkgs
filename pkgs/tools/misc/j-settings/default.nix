{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "aba28fbf97fb4c80f8416d9c6a75c25f3ea3b92f";
    	sha256 = "18mrk562x3rjwdxg1wy0jyg0gskvr0hv02rws60ygw1vhhsgrqcg";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
