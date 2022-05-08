{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "7312c6d6e6c912b31a3946604cba7423a5c01ac1";
    	sha256 = "128q7ssmbfhp97n3cjaqxa5y6hn4bynvxglvfqcvh2vs5y2p23ww";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
