### Gnome Cursor bugs on KDE
// When using Gnome apps in KDE Plasma, be sure to run this to workaround large cursors:
gsettings reset org.gnome.desktop.interface cursor-theme

## MacOS media keys wont work
// MacOS - When Media keys not working, likely disabled service:
launchctl load -w /System/Library/LaunchAgents/com.apple.rcd.plist
