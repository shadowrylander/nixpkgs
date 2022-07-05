{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "28fdebd82cade261ea18c8a1452441c2c00193a7";
    	sha256 = "0qhwwj9nj615frxb8fb38kmp1rqj7ai4v4b08rn0gl0k2x2nhvwi";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
