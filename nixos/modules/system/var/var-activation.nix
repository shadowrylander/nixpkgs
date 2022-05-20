{ config, lib, ... }:
let
  inherit (lib) stringAfter;
in {

  imports = [ ./var.nix ];

  config = {
    system.activationScripts.vard =
      stringAfter [ "users" "groups" ] config.system.build.varActivationCommands;
  };
}
