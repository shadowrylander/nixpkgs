{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "3ce398e9eb5bd054526366d0965119c83265efe2";
    	sha256 = "0cq7kfycd66137a6cjgfq0jkxp13jx01v03rrdjcci9d6gz1ysmh";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
