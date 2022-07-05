{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "d1d463dd65e9dc7975d173a47e60b2ef7bcc0133";
    	sha256 = "0nbla0rhdc51wmx6m80g91mh75p0xfk4nr3z5kxj5fxi9p5lykk5";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
