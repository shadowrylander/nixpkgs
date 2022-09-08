{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "14bb8d4677eb1229ed36c56b456484f0f66ac993";
        sha256 = "0s2g8bhz8zp5gvmmm548a683j7yw6q0f4y40h49y787pkvv6rgaf";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
