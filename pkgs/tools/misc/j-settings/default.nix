{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "7b3fc6e974a5c2927b2282b9cb9842f498d5a9ce";
    	sha256 = "0cq7kfycd66137a6cjgfq0jkxp13jx01v03rrdjcci9d6gz1ysmh";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
