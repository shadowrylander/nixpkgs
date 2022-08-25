{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "5f1c0601d52ab09fbf57a7e2d7ba21b09dc48936";
        sha256 = "0b4lxigi72m0s98hjg9gkak070vycmw1d8z3yj9gly248xg3fvsv";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
