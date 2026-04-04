# Desktop Files

## Find a "left over" desktop file

When uninstalling an app - There are sometimes artifacts left behind. `.desktop` files are a common artifact. Here is a command to find .desktop files with a command

```bash
grep -ril "appname" ~/.local/share/applications/ /usr/share/applications/ 2>/dev/null
```