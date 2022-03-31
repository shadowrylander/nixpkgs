{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "19f6aac9dc3712ed64806cc0db591c1c68367e4b";
    	sha256 = "0747x0xk8xdmzcpz43m6f578k1dpvxqlgrjxbj7n01kx6fism9p5";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src $out/bin
        chmod +x $out/bin/*.sh
    '';
}
