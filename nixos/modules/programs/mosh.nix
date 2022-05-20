{ config, lib, pkgs, ... }:

with lib;

let

  cfg  = config.programs.mosh;

in
{
  options.programs.mosh = {
    enable = mkEnableOption "mosh";
    withUtempter = mkOption {
      description = ''
        Whether to enable libutempter for mosh.
        This is required so that mosh can write to /var/run/utmp (which can be queried with `who` to display currently connected user sessions).
        Note, this will add a guid wrapper for the group utmp!
      '';
      default = true;
      type = lib.types.bool;
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to automatically open the specified port in the firewall.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ mosh ];
    networking.firewall.allowedUDPPortRanges = if cfg.openFirewall then [ { from = 60000; to = 61000; } ] else [];
    security.wrappers = mkIf cfg.withUtempter {
      utempter = {
        source = "${pkgs.libutempter}/lib/utempter/utempter";
        owner = "root";
        group = "utmp";
        setuid = false;
        setgid = true;
      };
    };
  };
}
