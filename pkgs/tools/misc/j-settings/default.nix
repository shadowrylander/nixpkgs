{ stdenv, fetchgit }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/sylvorg/settings.git";
        rev = "b93d05bb7f6b9bdfea34473d55d96b730226435e";
    	sha256 = "09kfmwbxxsjf1hg50wqf5lyv9cgpfl2cx6z0xw617zkaiiriix93";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src $out/bin
        chmod +x $out/bin/*
    '';
}
