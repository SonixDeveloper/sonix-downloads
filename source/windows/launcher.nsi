Unicode true
Name "Sonix"
OutFile "Sonix.exe"
Icon "sonix.ico"
RequestExecutionLevel user
SilentInstall silent
AutoCloseWindow true
Section
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" ""
  StrCmp $0 "" 0 launch
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" ""
  StrCmp $0 "" 0 launch
  SetRegView 64
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" ""
  StrCmp $0 "" 0 launch
  IfFileExists "$PROGRAMFILES32\Microsoft\Edge\Application\msedge.exe" 0 fallback
  StrCpy $0 "$PROGRAMFILES32\Microsoft\Edge\Application\msedge.exe"
  launch:
    ClearErrors
    Exec '"$0" --app="https://sonixdeveloper.github.io/sonix-downloads/launch.html"'
    IfErrors fallback done
  fallback:
    ExecShell "open" "https://sonixdeveloper.github.io/sonix-downloads/launch.html"
  done:
SectionEnd
