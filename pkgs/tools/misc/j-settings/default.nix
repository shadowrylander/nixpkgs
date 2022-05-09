{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "c1a998e45c11b6c95e32893dc139766c5e2a48bf";
    	sha256 = "0csjx9v9am85hdpw6v3c3r0nwkyv2kcwb6jgbjnqfbn88sir93xc";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
