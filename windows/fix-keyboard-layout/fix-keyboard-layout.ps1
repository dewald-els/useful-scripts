# fix-keyboard-layout.ps1
# Keeps en-GB locale but sets ONLY US International keyboard layout
# Run as your normal user (no admin required)

Write-Host "Fixing keyboard layout..."

# Set en-GB language with only US International layout (remove UK)
$langList = Get-WinUserLanguageList
$lang = $langList | Where-Object { $_.LanguageTag -eq 'en-GB' }
$lang.InputMethodTips.Clear()
$lang.InputMethodTips.Add('0809:00020409')
Set-WinUserLanguageList $langList -Force

# Disable language sync via Microsoft account
Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" `
    -Name "HttpAcceptLanguageOptOut" -Value 1 -Type DWord -Force

# Disable auto-population of keyboard layouts
$advPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\LanguageConfiguration"
if (-not (Test-Path $advPath)) { New-Item -Path $advPath -Force | Out-Null }
Set-ItemProperty -Path $advPath -Name "DisableAutoPopulation" -Value 1 -Type DWord -Force

# Confirm result
Write-Host "Done. Active layouts:"
Get-WinUserLanguageList | ForEach-Object { $_.InputMethodTips | ForEach-Object { Write-Host "  $_" } }
Write-Host ""
Write-Host "Sign out and back in if changes don't take effect immediately."
