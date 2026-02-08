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
