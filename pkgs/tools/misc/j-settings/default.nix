{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "2dcf1cbb9d54c8b36de649bed6fe7a85bd0a9902";
    	sha256 = "1iz1nfh4haxh7mkcry9y9q78yq7qcjrjbfv5hkjvlx2gcnz3b1zd";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
