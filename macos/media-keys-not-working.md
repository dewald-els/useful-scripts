## MacOS media keys wont work

MacOS - When Media keys not working, likely disabled service:

```shell
launchctl load -w /System/Library/LaunchAgents/com.apple.rcd.plist
```
