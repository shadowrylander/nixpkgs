{ stdenv, fetchGit }: with builtins; let
    function = "export";
    pname = "org-${function}";
in stdenv.mkDerivation rec {
    inherit pname;
    version = "1.0.0.0";

    src = fetchGit {
        url = "https://github.com/sylvorg/settings.git";
        ref = "main";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents "$out/bin"
        cp ${src}/${pname}.sh "$out/bin/${pname}"
        chmod +x "$out/bin/${pname}"
    '';
}