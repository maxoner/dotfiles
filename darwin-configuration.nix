{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [
    vim
    terraform
    haskellPackages.hoogle
  ];
  imports = [ <home-manager/nix-darwin> ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # tiling window manager for mac os https://github.com/koekeishiya/yabai
  services.yabai = {
    enable = false;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse          = "off";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_border                = "off";
      window_border_placement      = "exterior";
      window_border_width          = 2;
      window_border_radius         = 10;
      active_window_border_topmost = "off";
      window_topmost               = "on";
      window_shadow                = "on";
      active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp"; # also available "float"
      top_padding                  = 30;
      bottom_padding               = 8;
      left_padding                 = 8;
      right_padding                = 8;
      window_gap                   = 8;
    };
    extraConfig = ''
        # rules
        yabai -m rule --add app='System Preferences' manage=off
        yabai -m rule --add app=Telegram manage=off
        yabai -m rule --add app='Переводчик' manage=off
        yabai -m rule --add app='Cisco AnyConnect Secure Mobility Client' manage=off
        yabai -m rule --add app='Microsoft Teams' manage=off
        yabai -m rule --add app='Музыка' manage=off
        yabai -m rule --add app='Почта' manage=off

        # Any other arbitrary config here
      '';
    };

  # hotkey daemon: mapping hotkey to command https://github.com/koekeishiya/skhd
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      alt - t : yabai -m window --toggle float;\
           yabai -m window --grid 4:4:1:1:2:2
    '';
  };

  users.users.mpanin = {
    home = "/Users/mpanin";
  };

  home-manager.users.mpanin = { pkgs, ... }: {
    home.packages = [];

    programs = {

      zathura = {
        enable = true;
        package = pkgs.zathura;
        options = {
          # for everforest theme
          default-bg = "#2F383E";
          default-fg = "#D4C6AA";
        };
        extraConfig = ''
          set recolor-lightcolor \#2F383E
          set recolor-darkcolor \#D4C6AA
          set recolor
          # set recolor-keephue
          set guioptions none
        '';
      };

      # vscode = {
      #   enable = true;
      #   # package = pkgs.vscode;
      #   # extensions = with pkgs.vscode-extensions; [
      #   #   vscodevim.vim
      #   #   sainnhe.everforest
      #   #   ms-python.python
      #   #   golang.go

      #   # ];
      # };
      go = {
        enable = false;
        goPath = "go/";
      };

      };

    home.sessionVariables.GOPROXY = "goproxy.s.o3.ru";
    };


}
