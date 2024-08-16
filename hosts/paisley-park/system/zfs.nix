{
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
    };

    trim = {
      enable = true;
      interval = "monthly";
    };
  };
}
