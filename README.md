# gnome-to-ubuntu
 Here is how I made my GNOME looks Ubuntu
 
 First, install the Yaru GTK theme, Ubuntu fonts, ptyxis, gnome-tweaks or refine. And GNOME extensions: user-themes, appindicator, yaru-like-panel, dash to dock, desktop icons ng.
 
 ```nix
{ config, lib, pkgs, ... }:{

  nixpkgs.overlays = [
    (final: prev: {
      yaru-theme = prev.yaru-theme.overrideAttrs (oldAttrs: {
        # replace the gnome app grid icon to ubuntu
        postInstall = (oldAttrs.postInstall or "") + ''
          echo "Replacing app grid icon with Ubuntu logo..."
          cp $out/share/icons/Yaru/scalable/places/start-here-symbolic.svg \
             $out/share/icons/Yaru/scalable/actions/view-app-grid-symbolic.svg
        '';
      });
    })
  ];

  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    gnomeExtensions.yaru-like-panel
    gnomeExtensions.dash-to-dock
    gnomeExtensions.desktop-icons-ng-ding
    gnome-extension-manager
    refine
    adw-gtk3
    yaru-theme
    ubuntu-themes
    ptyxis
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      adwaita-fonts
      ubuntu-sans-mono
      ubuntu-sans
    ];
  };
}
 ```
 
 After install, you can turn on those extensions and manually set your gnome theme to Yaru in Refine. You can also import my dconf to GNOME:
 
 ```sh
dconf load -f / < ubuntu.dconf 
 ```
 
If my configuration file is incompatible with your GNOME, you can use `dconf reset -f /` to reset your gnome
