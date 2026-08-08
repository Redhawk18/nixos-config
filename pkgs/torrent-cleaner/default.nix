{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
  makeWrapper,
}:

let
  pythonEnv = python3.withPackages (ps: [
    ps.qbittorrent-api
    ps.xxhash
    ps.python-dotenv
    ps.requests
    ps.peewee
  ]);
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "torrent-cleaner";
  version = "0-unstable-2026-08-04";

  src = fetchFromGitHub {
    owner = "mankool0";
    repo = "torrent-cleaner";
    rev = "b51dd19a54e2fb1f1a42544f24136ddbf7a858e4";
    hash = "sha256-yCHZ1W/JSM2ZDNsR5/bCYd430pUqUblU32X3cecdqn8=";
  };

  nativeBuildInputs = [ makeWrapper ];

  # Pure Python app with no build system; the source is run as `python -m src.main`
  # from the repo root. Install the `src` package and wrap the interpreter so the
  # module can always be found regardless of the caller's working directory.
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/torrent-cleaner
    cp -r src $out/lib/torrent-cleaner/

    makeWrapper ${pythonEnv}/bin/python3 $out/bin/torrent-cleaner \
      --add-flags "-m src.main" \
      --chdir $out/lib/torrent-cleaner

    runHook postInstall
  '';

  meta = {
    description = "Automatically removes torrents from qBittorrent by seeding criteria while preserving hardlinked media";
    homepage = "https://github.com/mankool0/torrent-cleaner";
    license = lib.licenses.gpl3Plus;
    mainProgram = "torrent-cleaner";
    platforms = lib.platforms.linux;
  };
})
