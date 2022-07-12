{ stdenv, fetchFromGitHub }: with builtins; stdenv.mkDerivation rec {
    pname = "j-settings";
    version = "1.0.0.0";

    src = fetchFromGitHub {
        owner = "sylvorg";
        repo = "settings";
        rev = "df3d9a8919e92a02a903cca1c392056585ee6c0e";
    	sha256 = "1g9w4wvi8aidw3ik37hbbpmcwljn7mi6wi885r0lglvxbq7lgkl5";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out
        cp -r $src/bin $out/bin
        chmod +x $out/bin/*
    '';
}
