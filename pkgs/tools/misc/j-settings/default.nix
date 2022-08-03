{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "6b4ede18d2c83a77e8f747ee001fe041e44f2343";
    	sha256 = "1gd57bq0h2psib1n57fjb2g7mqmanl347awjaywxwhwg9ksp9i5q";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
