{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "5253618a5eebd1782e6f230d4f4cb3e43d46f238";
        sha256 = "0nf207hg4fr7za0damrckjmpinmqcfl2i31h6fvz4fmcl5wqssk9";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
