{ stdenv, fetchgit, lib }: stdenv.mkDerivation rec {
    pname = "mdsh";
    version = "1.0.0.0";

    src = fetchgit {
        url = "https://github.com/shadowrylander/mdsh.git";
        rev = "7e7af618a341eebd50e7825b062bc192079ad5fc";
        sha256 = "sha256-l03BHDHjlhwRepVDW9FnKCAXZ8AC6pgHQdQJtYOP5fE=";
    };

    phases = [ "installPhase" ];

    installPhase = ''
        mkdir --parents $out/bin
        cp "$src/bin/mdsh" $out/bin/
    '';

    # meta = with lib; {
    #     description = "A LISP that runs wherever Bash is";
    #     homepage = "https://github.com/chr15m/flk";
    #     # maintainers = [ maintainers.cmcdragonkai ];
    #     license = licenses.mpl20;
    #     # platforms = platforms.linux;
    # };
}