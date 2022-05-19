{ config, lib, ... }:
let
  inherit (lib) stringAfter;
in {

  imports = [ ./var.nix ];

  config = {
    system.activationScripts.var =
      stringAfter [ "users" "groups" ] config.system.build.varActivationCommands;
  };
}
