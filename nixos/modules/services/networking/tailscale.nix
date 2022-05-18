# Adapted From: https://tailscale.com/blog/nixos-minecraft/
# And: https://discourse.nixos.org/t/solved-possible-to-automatically-authenticate-tailscale-after-every-rebuild-reboot/14296

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.tailscale;
  firewallOn = config.networking.firewall.enable;
  rpfMode = config.networking.firewall.checkReversePath;
  rpfIsStrict = rpfMode == true || rpfMode == "strict";
in {
  meta.maintainers = with maintainers; [ danderson mbaillie twitchyliquid64 ];

  options.services.tailscale = {
    enable = mkEnableOption "Tailscale client daemon";

    port = mkOption {
      type = types.port;
      default = 41641;
      description = "The port to listen on for tunnel traffic (0=autoselect).";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to automatically open the specified port in the firewall.";
    };

    interfaceName = mkOption {
      type = types.str;
      default = "tailscale0";
      description = ''The interface name for tunnel traffic. Use "userspace-networking" (beta) to not use TUN.'';
    };

    trustInterface = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to automatically trust the specified interface in the firewall.";
    };

    permitCertUid = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
      description = "Username or user ID of the user allowed to to fetch Tailscale TLS certificates for the node.";
    };

    authkey = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
      description = ''
      Authentication key.

      Warning: Consider using authfile instead if you do not
      want to store the key in the world-readable Nix store.
      '';
    };

    authfile = mkOption {
      example = "/private/tailscale_auth_key";
      type = with types; nullOr str;
      default = null;
      description = ''
        File with authentication key.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.tailscale;
      defaultText = literalExpression "pkgs.tailscale";
      description = "The package to use for tailscale";
    };
  };

  config = mkIf cfg.enable {
    warnings = optional (firewallOn && rpfIsStrict) "Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups. Consider setting `networking.firewall.checkReversePath` = 'loose'";
    environment.systemPackages = [ cfg.package ]; # for the CLI
    networking.firewall = {
      trustedInterfaces = if cfg.trustInterface then [ cfg.interfaceName ] else [];
      allowedUDPPorts = if cfg.openFirewall then [ cfg.port ] else [];
    };
    systemd.packages = [ cfg.package ];
    systemd.services = {
      tailscaled = {
        wantedBy = [ "multi-user.target" ];
        path = [
          pkgs.openresolv # for configuring DNS in some configs
          pkgs.procps     # for collecting running services (opt-in feature)
          pkgs.glibc      # for `getent` to look up user shells
        ];
        serviceConfig.Environment = [
          "PORT=${toString cfg.port}"
          ''"FLAGS=--tun ${lib.escapeShellArg cfg.interfaceName}"''
        ] ++ (lib.optionals (cfg.permitCertUid != null) [
          "TS_PERMIT_CERT_UID=${cfg.permitCertUid}"
        ]);
        # Restart tailscaled with a single `systemctl restart` at the
        # end of activation, rather than a `stop` followed by a later
        # `start`. Activation over Tailscale can hang for tens of
        # seconds in the stop+start setup, if the activation script has
        # a significant delay between the stop and start phases
        # (e.g. script blocked on another unit with a slow shutdown).
        #
        # Tailscale is aware of the correctness tradeoff involved, and
        # already makes its upstream systemd unit robust against unit
        # version mismatches on restart for compatibility with other
        # linux distros.
        stopIfChanged = false;
      };
      tailscale-autoconnect = mkIf (cfg.authkey != null || cfg.authfile != null) {
        description = "Automatic connection to Tailscale";

        # make sure tailscale is running before trying to connect to tailscale
        after = [ "network-pre.target" "tailscale.service" ];
        wants = [ "network-pre.target" "tailscale.service" ];
        wantedBy = [ "multi-user.target" ];

        # set this service as a oneshot job
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''
            # wait for tailscaled to settle
            sleep 2

            # check if we are already authenticated to tailscale
            echo "Waiting for tailscale.service start completion ..."
            status="$(${cfg.package}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
            if [ $status = "Running" ]; then # if so, then do nothing
              echo "Already authenticated to Tailscale, exiting."
              exit 0
            fi

            # otherwise authenticate with tailscale
            echo "Authenticating with Tailscale ..."
            ${cfg.package}/bin/tailscale up -authkey \
              ${(if (cfg.authkey != null) then cfg.authkey else (readFile cfg.authfile))}
          '';
        };
      };
    };
  };
}
