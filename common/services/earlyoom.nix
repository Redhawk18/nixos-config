{
  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid"
      "^(X|plasma.*|konsole|kwin)$"
      "--prefer"
      "^(slack|electron|libreoffice|discord|plexamp|rust-analyzer)$"
    ];
  };
}
