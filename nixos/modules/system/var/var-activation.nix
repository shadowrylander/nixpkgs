{ config, lib, ... }:
let
  inherit (lib) stringAfter;
in {

  imports = [ ./var.nix ];

  config = {
    system.activationScripts.vars =
      stringAfter [ "users" "groups" ] config.system.build.varActivationCommands;
  };
}
