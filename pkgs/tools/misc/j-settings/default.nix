{ stdenv }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchGit {
        url = "https://github.com/sylvorg/settings.git";
        ref = "main";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src $out/bin
        chmod +x $out/bin/*.sh
    '';
}