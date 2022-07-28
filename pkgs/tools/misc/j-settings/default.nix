{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "60aa243093e6d8b86be9e3fbcee4647e034252da";
    	sha256 = "15f9cf8m9wkq6fg868z5cv8dgrbljs1vjwwvgwx3ykpxnhxd5hn3";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
