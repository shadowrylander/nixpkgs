{ lib
, coreutils
, fakechroot
, fakeroot
, evalMinimalConfig
, pkgsModule
, runCommand
, util-linux
, vmTools
, writeText
}:
let
  node = evalMinimalConfig ({ config, ... }: {
    imports = [ pkgsModule ../var/var.nix ];
    environment.vars."passwd" = {
      text = passwdText;
    };
    environment.vars."hosts" = {
      text = hostsText;
      mode = "0751";
    };
  });
  passwdText = ''
    root:x:0:0:System administrator:/root:/run/current-system/sw/bin/bash
  '';
  hostsText = ''
    127.0.0.1 localhost
    ::1 localhost
    # testing...
  '';
in
lib.recurseIntoAttrs {
  test-var-vm =
    vmTools.runInLinuxVM (runCommand "test-var-vm" { } ''
      mkdir -p /var
      ${node.config.system.build.varActivationCommands}
      set -x
      [[ -L /var/passwd ]]
      diff /var/passwd ${writeText "expected-passwd" passwdText}
      [[ 751 = $(stat --format %a /var/hosts) ]]
      diff /var/hosts ${writeText "expected-hosts" hostsText}
      set +x
      touch $out
    '');

  # fakeroot is behaving weird
  test-var-fakeroot =
    runCommand "test-var"
      {
        nativeBuildInputs = [
          fakeroot
          fakechroot
          # for chroot
          coreutils
          # fakechroot needs getopt, which is provided by util-linux
          util-linux
        ];
        fakeRootCommands = ''
          mkdir -p /var
          ${node.config.system.build.varActivationCommands}
          diff /var/hosts ${writeText "expected-hosts" hostsText}
          touch $out
        '';
      } ''
      mkdir fake-root
      export FAKECHROOT_EXCLUDE_PATH=/dev:/proc:/sys:${builtins.storeDir}:$out
      fakechroot fakeroot chroot $PWD/fake-root bash -c 'source $stdenv/setup; eval "$fakeRootCommands"'
    '';

}
