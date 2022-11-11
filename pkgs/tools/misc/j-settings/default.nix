{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "f150a88abf2e5175cce88c108a4decf98d276f19";
        sha256 = "1dsmq01nqcz0xvwsmwq81w7b1kn3293n2kh85ak1jq7sgpq2ish2";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
