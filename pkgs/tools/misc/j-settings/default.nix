{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "a53d6a6332c4da9e7e74c610c6fd7ec565015f4c";
    	sha256 = "1wrvlic0947a5ajn1mjnmcqjp8ihjbmiknafhcnxld40zlyh7v4z";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
