{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "ddbaa2b0a16fa0bed106ba323719e6c19bdf5d84";
    	sha256 = "0il0a5a9k42sjkdf8yb5x920nqs7adafmycznjlqlnvaz975z93d";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src $out/bin
        chmod +x $out/bin/*.sh
    '';
}
