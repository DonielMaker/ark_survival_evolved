{ self, steam-fetcher, }: { config, pkgs, lib, ... }: 

let
  cfg = config.services.junkyard;
in 

{
    config.nixpkgs.overlays = [self.overlays.default steam-fetcher.overlays.default];

    options.services.ark = {
        enable = lib.mkEnableOption (lib.mdDoc "ARK: Survival Evolved Dedicated Server");

        port = lib.mkOption {
            type = lib.types.port;
            default = 7777;
            description = lib.mdDoc "The ports on which to listen for incoming connections.";
        };

        openFirewall = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = lib.mdDoc "Whether to open ports in the firewall.";
        };

        # Any options you want to expose for the game server, which will vary from game to game.
    };

    config = {
        users = {
            users.ark = {
                isSystemUser = true;
                group = "ark";
                home = /srv/ark;
            };
            groups.junkyard = {};
        };

        systemd.services.ark = {
            description = "ARK: Survival Evolved dedicated server";
            requires = ["network.target"];
            after = ["network.target"];
            wantedBy = ["multi-user.target"];

            serviceConfig = {
                Type = "exec";
                User = "junkyard";
                ExecStart = "${pkgs.ark_survival_evolved-server}/ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?SessionName=Auschwitz?ServerPassword=69419?ServerAdminPassword=69420 -server -log";
            };
        };

        networking.firewall = lib.mkIf cfg.openFirewall {
            allowedUDPPorts = [
                cfg.port
                (cfg.port + 1) # UDP Socket port
                (cfg.port + 27015) # Steam Server Browser
            ];
        };
    };
}
