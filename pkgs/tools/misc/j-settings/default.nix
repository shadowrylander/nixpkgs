{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "1c0f932e2fb928fb1df098d8a7c6ee37208e0160";
    	sha256 = "19njkj69rmyn6zaw0cc55lvf5qqab4asx2252xlk2a6r474gfbrv";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
