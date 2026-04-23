# fix-keyboard-layout

Windows keeps automatically adding a UK keyboard layout when your system locale is set to `en-GB`. This script removes it and sets **US International** as the only keyboard layout, then disables the Microsoft account language sync that causes it to come back.

## Usage

Right-click `fix-keyboard-layout.ps1` and choose **Run with PowerShell**.

Or if blocked by execution policy:

```powershell
powershell -ExecutionPolicy Bypass -File .\fix-keyboard-layout.ps1
```

Sign out and back in if the change doesn't take effect immediately.
