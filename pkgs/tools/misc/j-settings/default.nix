{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "717c7597141575635acc07491f7d7e8340618275";
        sha256 = "1vpayln0mh0b9dbysq9ajgcrakzr8q9pnz3dxmxfy0vqbx0vgsk9";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
