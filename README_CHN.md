# gnome-to-ubuntu
 以下是我如何让我的 GNOME 界面看起来像 Ubuntu 的方法。
 
 ![Example](https://raw.githubusercontent.com/YisuiDenghua/gnome-to-ubuntu/refs/heads/main/eg.png)
 
 首先，安装  Yaru GTK 主题, Ubuntu 字体, ptyxis, gnome-tweaks 或 refine. 以及 下列 GNOME 扩展: user-themes, appindicator, yaru-like-panel, dash to dock, desktop icons ng.
 
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
 
 安装完成后，您可以启用这些扩展程序，并在  Refine 中手动将  GNOME 主题设置为 Yaru。或者，您也可以将我的 dconf 文件导入到 GNOME 中。导入我的  dconf 文件之前，建议您先备份自己的 dconf 文件。:
 
 ```sh
 dconf dump / > backup.dconf
 ```
 
然后，导入我的。
 
 
 ```sh
dconf load -f / < ubuntu.dconf 
 ```
 
如果我的配置文件与您的 GNOME 不兼容，您可以使用 `dconf load -f / < saved_settings.dconf` 恢复到您的备份 dconf，或者使用 `dconf reset -f /` 重置您的 GNOME。
