@echo off
color 0A
title Instalação de Programas - Menu

:MENU7
cls
echo =======================================
echo          INSTALACAO DE PROGRAMAS
echo =======================================
echo [1] Instalar programas via winget
echo [2] Instalar programas via chocolatey
echo [3] Baixar programas de terceiros (links oficiais)
echo [0] Voltar ao menu principal
echo =======================================
set /p opt="Escolha uma opcao: "

if "%opt%"=="1" goto WINGET_INSTALL
if "%opt%"=="2" goto CHOCO_INSTALL
if "%opt%"=="3" goto DOWNLOAD_LINKS
if "%opt%"=="0" goto MENU
goto MENU7

:WINGET_INSTALL
cls
echo =======================================
echo      INSTALAR PROGRAMAS VIA WINGET
echo =======================================
echo 1. Google Chrome
echo 2. Anydesk
echo 3. Teamviewer
echo 4. Bitwarden
echo 5. Foxit PDF Reader
echo 6. Gimp
echo 7. Notepad++
echo 8. Visual Studio Code
echo 9. GitHub Desktop
echo 10. VLC
echo 11. Spotify
echo 12. 7-Zip
echo 13. K-lite Codec Pack Full
echo 14. Java Runtime Environment
echo 15. Git
echo 16. WSL (Ubuntu/Kali Linux)
echo 17. PowerShell 7
echo 18. OnlyOffice
echo 19. OBS Studio
echo 20. Peazip
echo 21. Angry IP Scanner
echo 0. Voltar
echo =======================================
set /p choice="Escolha o programa para instalar: "

if "%choice%"=="1" winget install Google.Chrome -e
if "%choice%"=="2" winget install AnyDeskSoftwareGmbH.AnyDesk -e
if "%choice%"=="3" winget install TeamViewer.TeamViewer -e
if "%choice%"=="4" winget install Bitwarden.Bitwarden -e
if "%choice%"=="5" winget install Foxit.FoxitReader -e
if "%choice%"=="6" winget install GIMP.GIMP -e
if "%choice%"=="7" winget install Notepad++.Notepad++ -e
if "%choice%"=="8" winget install Microsoft.VisualStudioCode -e
if "%choice%"=="9" winget install GitHub.GitHubDesktop -e
if "%choice%"=="10" winget install VideoLAN.VLC -e
if "%choice%"=="11" winget install Spotify.Spotify -e
if "%choice%"=="12" winget install 7zip.7zip -e
if "%choice%"=="13" winget install CodecGuide.K-LiteCodecPack.Mega -e
if "%choice%"=="14" winget install Oracle.JavaRuntimeEnvironment -e
if "%choice%"=="15" winget install Git.Git -e
if "%choice%"=="16" winget install Microsoft.WSL -e
if "%choice%"=="17" winget install Microsoft.PowerShell -e
if "%choice%"=="18" winget install ONLYOFFICE.DesktopEditors -e
if "%choice%"=="19" winget install OBSProject.OBSStudio -e
if "%choice%"=="20" winget install Giorgiotani.Peazip -e
if "%choice%"=="21" winget install angryziber.AngryIPScanner -e
if "%choice%"=="0" goto MENU7

pause
goto WINGET_INSTALL

:CHOCO_INSTALL
cls
echo =======================================
echo      INSTALAR PROGRAMAS VIA CHOCOLATEY
echo =======================================
echo 1. Google Chrome
echo 2. Anydesk
echo 3. Teamviewer
echo 4. Bitwarden
echo 5. Foxit PDF Reader
echo 6. Gimp
echo 7. Notepad++
echo 8. Visual Studio Code
echo 9. GitHub Desktop
echo 10. VLC
echo 11. Spotify
echo 12. 7-Zip
echo 13. K-lite Codec Pack Full
echo 14. Java Runtime Environment (JRE8)
echo 15. Git
echo 16. WSL
echo 17. PowerShell 7
echo 18. OnlyOffice
echo 19. OBS Studio
echo 20. Peazip
echo 21. Angry IP Scanner
echo 0. Voltar
echo =======================================
set /p choice="Escolha o programa para instalar: "

if "%choice%"=="1" choco install googlechrome -y
if "%choice%"=="2" choco install anydesk -y
if "%choice%"=="3" choco install teamviewer -y
if "%choice%"=="4" choco install bitwarden -y
if "%choice%"=="5" choco install foxitreader -y
if "%choice%"=="6" choco install gimp -y
if "%choice%"=="7" choco install notepadplusplus -y
if "%choice%"=="8" choco install vscode -y
if "%choice%"=="9" choco install github-desktop -y
if "%choice%"=="10" choco install vlc -y
if "%choice%"=="11" choco install spotify -y
if "%choice%"=="12" choco install 7zip -y
if "%choice%"=="13" choco install k-litecodecpackmega -y
if "%choice%"=="14" choco install jre8 -y
if "%choice%"=="15" choco install git -y
if "%choice%"=="16" choco install wsl -y
if "%choice%"=="17" choco install powershell -y
if "%choice%"=="18" choco install onlyoffice -y
if "%choice%"=="19" choco install obs-studio -y
if "%choice%"=="20" choco install peazip -y
if "%choice%"=="21" choco install angryip -y
if "%choice%"=="0" goto MENU7

pause
goto CHOCO_INSTALL

:DOWNLOAD_LINKS
cls
echo =======================================
echo         DOWNLOADS DE TERCEIROS
echo =======================================
echo 1. Free Download Manager  - https://www.freedownloadmanager.org/pt/download.htm
echo 2. Office 2024             - https://terabox.com/s/1gHLymvkhNVN9RANV4LRU0w
echo 3. Ativador Office 2024   - https://terabox.com/s/1PTjkxwGlpnT69DdRSPDuUQ
echo 4. VirtualBox             - https://www.virtualbox.org/wiki/Downloads
echo 5. Winrar + Ativador      - https://terabox.com/s/17sQw7Taye19qrCpL6M4-DA
echo 6. ADB - Platform Tools  - https://developer.android.com/tools/releases/platform-tools?hl=pt-br
echo 7. Bulk Crap Uninstaller - https://github.com/Klocman/Bulk-Crap-Uninstaller/releases
echo 8. Visual C++ Redistributable - https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/
echo 9. Windows Update Blocker - https://www.sordum.org/9470/windows-update-blocker-v1-8/
echo 10. DaVinci Resolve       - https://www.computerbase.de/downloads/audio-und-video/davinci-resolve/
echo 11. OBS Studio            - https://www.computerbase.de/downloads/audio-und-video/obs-studio/
echo 12. NextDNS              - https://my.nextdns.io/login
echo 13. Kaspersky + VPN      - https://www.kaspersky.com.br/premium
echo 14. RyTuneX              - https://github.com/rayenghanmi/RyTuneX
echo 15. RustDesk             - https://rustdesk.com/pt/
echo 16. WinUtil (ChrisTitus) - https://github.com/ChrisTitusTech/winutil
echo 17. CrapFixer            - https://github.com/builtbybel/CrapFixer
echo 18. ADB APP CONTROL      - https://adbappcontrol.com/en/
echo 19. Windows Memory Cleaner - https://github.com/IgorMundstein/WinMemoryCleaner
echo 20. Clean Tools Plus     - https://github.com/braulioreis27/CleanTools-Plus
echo 21. Defender Control     - https://www.sordum.org/9480/defender-control-v2-1/
echo 22. Driver Store Explorer - https://github.com/lostindark/DriverStoreExplorer
echo 23. OCCT                 - https://www.ocbase.com/download
echo 0. Voltar
echo =======================================
set /p dchoice="Escolha o programa para abrir o link: "

if "%dchoice%"=="1" start https://www.freedownloadmanager.org/pt/download.htm
if "%dchoice%"=="2" start https://terabox.com/s/1gHLymvkhNVN9RANV4LRU0w
if "%dchoice%"=="3" start https://terabox.com/s/1PTjkxwGlpnT69DdRSPDuUQ
if "%dchoice%"=="4" start https://www.virtualbox.org/wiki/Downloads
if "%dchoice%"=="5" start https://terabox.com/s/17sQw7Taye19qrCpL6M4-DA
if "%dchoice%"=="6" start https://developer.android.com/tools/releases/platform-tools?hl=pt-br
if "%dchoice%"=="7" start https://github.com/Klocman/Bulk-Crap-Uninstaller/releases
if "%dchoice%"=="8" start https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/
if "%dchoice%"=="9" start https://www.sordum.org/9470/windows-update-blocker-v1-8/
if "%dchoice%"=="10" start https://www.computerbase.de/downloads/audio-und-video/davinci-resolve/
if "%dchoice%"=="11" start https://www.computerbase.de/downloads/audio-und-video/obs-studio/
if "%dchoice%"=="12" start https://my.nextdns.io/login
if "%dchoice%"=="13" start https://www.kaspersky.com.br/premium
if "%dchoice%"=="14" start https://github.com/rayenghanmi/RyTuneX
if "%dchoice%"=="15" start https://rustdesk.com/pt/
if "%dchoice%"=="16" start https://github.com/ChrisTitusTech/winutil
if "%dchoice%"=="17" start https://github.com/builtbybel/CrapFixer
if "%dchoice%"=="18" start https://adbappcontrol.com/en/
if "%dchoice%"=="19" start https://github.com/IgorMundstein/WinMemoryCleaner
if "%dchoice%"=="20" start https://github.com/braulioreis27/CleanTools-Plus
if "%dchoice%"=="21" start https://www.sordum.org/9480/defender-control-v2-1/
if "%dchoice%"=="22" start https://github.com/lostindark/DriverStoreExplorer
if "%dchoice%"=="23" start https://www.ocbase.com/download
if "%dchoice%"=="0" goto MENU7
goto DOWNLOAD_LINKS
