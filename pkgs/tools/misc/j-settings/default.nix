{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "3cffecc6558c380148c67624a488e8a01105ae63";
    	sha256 = "1b7faimwh06qcgr4yd6aw0vqaxjsgsc175j7sq3d0p9vv5y7ak9w";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
