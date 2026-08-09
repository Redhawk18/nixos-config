{ ... }:
# Shared storage permissions for the media services.
#
# All of these live on the single `boundman` ZFS dataset, which is what makes
# hardlinks + atomic (instant) moves possible between the download dir and the
# library. For that to work without running everything as root, every media
# service runs as its own user but in the shared `media` group (see
# system/users.nix and the individual services/*.nix), with UMask=0002 so new
# files are group-writable (664 files / 775 dirs).
#
# The rules below keep the *top-level* dirs owned by the media group with the
# setgid bit (2xxx) set, so any new file/dir created underneath inherits the
# `media` group automatically. Existing contents are fixed up once by the
# one-time migration in README/notes (chgrp -R media + setgid on dirs).
{
  systemd.tmpfiles.rules = [
    # qbittorrent downloads
    "d /boundman/qbittorrent      2775 qbittorrent media -"
    # cross-seed hardlink target
    "d /boundman/cross-seed-links 2775 cross-seed  media -"
    # Plex library / *arr root folders. Kept world-writable (2777) because it is
    # also the Samba/NFS share (server_files) written to as `nobody`; the setgid
    # bit still forces new content into the `media` group so the arrs can manage
    # what they import.
    "d /boundman/server_files     2777 root        media -"
  ];
}
