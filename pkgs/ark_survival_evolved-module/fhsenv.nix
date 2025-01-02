{ lib, buildFHSUserEnv, writeScript, ark_survival_evolved-server-unwrapped, steamworks-sdk-redist, ServerPassword, AdminPassword}:
buildFHSUserEnv {
  name = "ark_survival_evolved-server";

  runScript = "./ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?SessionName=Auschwitz?ServerPassword=${ServerPassword}?ServerAdminPassword=${AdminPassword} -server -log";

  targetPkgs = pkgs: [
    ark_survival_evolved-server-unwrapped
    steamworks-sdk-redist
  ];

  inherit (ark_survival_evolved-server-unwrapped) meta;
}
