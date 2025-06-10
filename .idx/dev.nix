# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs
    pkgs.nodePackages.typescript
    pkgs.ffmpeg
    pkgs.imagemagick
    pkgs.git
    pkgs.neofetch
    pkgs.libwebp
    pkgs.speedtest-cli
    pkgs.wget
    pkgs.yarn
    pkgs.libuuid
  ];
  # Sets environment variables in the workspace
  env = {
  	LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    	pkgs.libuuid
    ];
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        npm-install = "npm install";
        default.openFiles = [ ".idx/dev.nix"];
      };
      # Runs when the workspace is (re)started
      onStart = {
        npm-start = "npm start";
      };
    };
  };
}
