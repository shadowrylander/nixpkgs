{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "3ba0471737248bd5b1faf747ed63e0365342fa72";
    	sha256 = "0pp12iyf4mwsj4yf47vcabk87v4fkq90vbjjir5j355g7cirx7xr";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
