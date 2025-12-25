{
  services.atticd = {
    enable = true;

    # Replace with absolute path to your environment file
    environmentFile = "/etc/atticd.env";

    settings = {
      listen = "[::]:47715";
      # storage = {
      #   type = "local";
      #   path = "/home/attic";
      # };

      jwt = { };
    };
  };
}
