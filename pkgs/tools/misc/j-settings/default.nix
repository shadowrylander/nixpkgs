{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "d1efc5ab242a98ed57e61ac719eea773f3c95229";
    	sha256 = "03q46wa0d5lfcjaxa83vwlm0sl3lx61rwh3kw374yibgg081mn8q";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
