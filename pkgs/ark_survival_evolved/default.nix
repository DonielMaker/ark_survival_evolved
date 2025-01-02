{ lib, stdenv, fetchSteam}:

stdenv.mkDerivation rec {
    name = "ARK: Survival Evolved";
    version = "0.0.1";
    src = fetchSteam {
        inherit name;
        appId = "346110";
        depotId = "1318680";
        manifestId = "8060274748931292766";
        # Enable debug logging from DepotDownloader.
        debug = true;
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    # Skip phases that don't apply to prebuilt binaries.
    dontBuild = true;
    dontConfigure = true;
    dontFixup = true;

    installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -r $src/* $out

        chmod +x $out/ShooterGame/Binaries/Linux/ShooterGame

        runHook postInstall
    '';

    meta = with lib; {
        description = "Some dedicated server";
        homepage = "https://steamdb.info/app/xyz/";
        changelog = "https://store.steampowered.com/news/app/xyz?updates=true";
        sourceProvenance = with sourceTypes; [
            binaryNativeCode # Steam games are always going to contain some native binary component.
            binaryBytecode # e.g. Unity games using C#
        ];
        license = licenses.unfree;
        platforms = ["x86_64-linux"];
    };
}
