{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "d86dd411fc870c0ee70622bce213d69ae2aaa9a1";
	sha256 = "0m50l56bw8x36ila0d6vyrgfznnan0w4lmpk82ilh2g0cpi677bj";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src $out/bin
        chmod +x $out/bin/*.sh
    '';
}
