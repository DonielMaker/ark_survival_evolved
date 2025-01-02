{ 
    buildFHSUserEnv,
    writeScript,
    ark_survival_evolved-server-unwrapped,
    steamworks-sdk-redist
}:

buildFHSUserEnv {
  name = "ark_survival_evolved-server";

  runScript = "./ShooterGame/Binaries/Linux/ShooterGameServer TheIsland?listen?SessionName=Auschwitz?ServerPassword=69419?ServerAdminPassword=69420 -server -log";

  targetPkgs = pkgs: [
    ark_survival_evolved-server-unwrapped
    steamworks-sdk-redist
  ];

  inherit (ark_survival_evolved-server-unwrapped) meta;
}
