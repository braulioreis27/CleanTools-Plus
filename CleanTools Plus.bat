@echo off
setlocal enabledelayedexpansion

color 0A
title Projeto Completo de Manutencao do Windows

:: ---------- Variáveis Globais ----------
:: Captura do IP local ativo (IPv4)
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set "ip=%%a"
)
set "ip=!ip:~1!"

:: Captura da versão do Windows
for /f "tokens=2 delims==" %%v in ('wmic os get version /value ^| find "="') do set "winver=%%v"

:: ---------- Função Principal / Menu ----------
:MAINMENU
cls
echo ================================================
echo       PROJETO DE MANUTENCAO WINDOWS 10/11
echo ================================================
echo Data: %date%    Hora: %time%
echo Endereco IP Local: !ip!
echo Versao do Windows: !winver!
echo.
echo MELHORIAS E DESTAQUES:
echo - Menus intuitivos para limpeza, reparo, otimizacoes e instalacao
echo - Backups e gerenciamento de drivers integrados com facilidade
echo - Otimizacoes avancadas para SSD, rede, CPU Ryzen e jogos
echo - Atualizacoes via winget e chocolatey + links para downloads confiaveis
echo - Ferramentas avancadas para diagnosticos e manutencao rapida
echo.
echo ================================================
echo MENU PRINCIPAL
echo ================================================
echo [1] Limpeza do Sistema (Simples e Completa)
echo [2] Reparo Avancado do Sistema (SFC, DISM)
echo [3] Otimizacoes do Windows (SSD, rede, energia, Ryzen, etc)
echo [4] Backup e Gerenciamento de Drivers
echo [5] Atualizacoes de Programas (Windows Update, winget, choco)
echo [6] Ferramentas Avancadas (Process Explorer, Regedit, etc)
echo [7] Instalacao de Programas (winget, chocolatey e links)
echo [0] Sair
echo ================================================
set /p "mainopt=Escolha uma opcao: "
if "!mainopt!"=="1" call :LIMPEZA_MENU & goto MAINMENU
if "!mainopt!"=="2" call :REPARO_MENU & goto MAINMENU
if "!mainopt!"=="3" call :OTIMIZACAO_MENU & goto MAINMENU
if "!mainopt!"=="4" call :DRIVERS_MENU & goto MAINMENU
if "!mainopt!"=="5" call :ATUALIZACOES_MENU & goto MAINMENU
if "!mainopt!"=="6" call :FERRAMENTAS_MENU & goto MAINMENU
if "!mainopt!"=="7" call :INSTALACOES_MENU & goto MAINMENU
if "!mainopt!"=="0" exit /b
goto MAINMENU

:: ---------- LIMPEZA ----------
:LIMPEZA_MENU
cls
echo ==== LIMPEZA DO SISTEMA ====
echo [1] Limpeza Simples
echo [2] Limpeza Completa
echo [0] Voltar
set /p "limopt=Escolha uma opcao: "
if "!limopt!"=="1" call :LIMPEZA_SIMPLES & goto LIMPEZA_MENU
if "!limopt!"=="2" call :LIMPEZA_COMPLETA & goto LIMPEZA_MENU
if "!limopt!"=="0" exit /b
goto LIMPEZA_MENU

:LIMPEZA_SIMPLES
cls
echo Executando limpeza simples...
del /q /f "%temp%\*" >nul 2>&1
del /q /f "C:\Windows\Temp\*" >nul 2>&1
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >nul 2>&1
del /s /f /q %temp%\*.*
del /s /f /q C:\Windows\Temp\*.*
del /s /f /q %userprofile%\recent\*.*
ipconfig /flushdns
cleanmgr /sagerun:1 >nul 2>&1
::------------LIMPEZA DO CHHROME---------------
echo Limpando cache do Chrome...
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
::------------LIMPEZA DO FIREFOX---------------
echo Limpando cache do Firefox...
for /d %%G in ("%APPDATA%\Mozilla\Firefox\Profiles\*.default-release") do (
 del /s /f /q "%%G\cache2\*.*" >nul 2>&1
 )
 ::------------LIMPEZA DO EDGE---------------
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
if errorlevel 1 (
    echo Aviso: Alguns arquivos nao puderam ser removidos.
) else (
    echo Limpeza simples concluida!
)
pause
exit /b

:LIMPEZA_COMPLETA
cls
echo Executando limpeza completa...
del /s /q /f "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
del /s /q /f "%temp%\*" >nul 2>&1
del /s /q /f "C:\Windows\Prefetch\*.*" >nul 2>&1
del /s /q /f "C:\Windows\Temp\*.*" >nul 2>&1
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >nul 2>&1
net stop wuauserv >nul 2>&1
del /q /f "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
del /q /f "%USERPROFILE%\Downloads\*" >nul 2>&1
del /f /s /q %systemdrive%\*.tmp >nul 2>&1
del /f /s /q %systemdrive%\*.log >nul 2>&1
del /f /s /q %systemdrive%\*.bak >nul 2>&1
del /f /q "%USERPROFILE%\cookies*.*" >nul 2>&1
del /f /q "%USERPROFILE%\recent*.*" >nul 2>&1
del /q /f "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /s /f /q %temp%\*.*
ipconfig /flushdns
cleanmgr /sagerun:1 >nul 2>&1
::------------LIMPEZA DO CHHROME---------------
echo Limpando cache do Chrome...
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
::------------LIMPEZA DO FIREFOX---------------
echo Limpando cache do Firefox...
for /d %%G in ("%APPDATA%\Mozilla\Firefox\Profiles\*.default-release") do (
 del /s /f /q "%%G\cache2\*.*" >nul 2>&1
 )
 ::------------LIMPEZA DO EDGE---------------
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1


::------------ LIMPEZA DO Free Download Manager ---------------
echo Limpando cache do FreeDownloadManager...
 del /s /q "%LOCALAPPDATA%\FreeDownloadManager.ORG\Free Download Manager\*.*"
::------------ LIMPEZA DO Angry IP Scanner ---------------
echo Limpando cache do Angry IP Scanner...
del /s /q "%USERPROFILE%\.ipscan\*.*"
del /s /q "%USERPROFILE%\.java\.userPrefs\ipscan\*.*"
::------------ LIMPEZA DO Audacity ---------------
echo Limpando cache do Audacity...
del /s /q "%LOCALAPPDATA%\Audacity\SessionData\*.*"
del /s /q "%APPDATA%\Audacity\*.*"
::------------ LIMPEZA DO Disk SpeedUp ---------------
echo Limpando cache do Disk SpeedUp...
del /s /q "%APPDATA%\Disk SpeedUp\Temp\*.*"
del /s /q "%LOCALAPPDATA%\Disk SpeedUp\Temp\*.*"
::------------ LIMPEZA DO GIMP ---------------
echo Limpando cache do GIMP...
del /s /q "%APPDATA%\GIMP\2.10\tmp\*.*"
::------------ LIMPEZA DO Kaspersky ---------------
echo Limpando cache do Kaspersky...
del /s /q "%ProgramData%\Kaspersky Lab\AVP21.3\Temp\*.*"
::------------ LIMPEZA DO Notepad++---------------
echo Limpando cache do Notepad++ ...
del /s /q "%APPDATA%\Notepad++\backup\*.*"
::------------ LIMPEZA DO OBS Studio ---------------
echo Limpando cache do OBS Studio...
del /s /q "%APPDATA%\obs-studio\cache\*.*"
::------------ LIMPEZA DO Visual Studio Code ---------------
echo Limpando cache do Visual Studio Code ...
del /s /q "%APPDATA%\Code\Cache\*.*"
del /s /q "%APPDATA%\Code\CachedData\*.*"
del /s /q "%APPDATA%\Code\logs\*.*"
::------------ LIMPEZA DO WSL (Windows Subsystem for Linux) ---------------
echo Limpando cache do WSl...
del /s /q "%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_*\LocalCache\*.*"
::------------ LIMPEZA DO VLC Media Player ---------------
echo Limpando cache do VLC...
del /s /q "%APPDATA%\vlc\cache\*.*"
del /s /q "%APPDATA%\vlc\*thumbs.db"
::------------ LIMPEZA DO Oracle VirtualBox ---------------
echo Limpando cache do Virtualbox...
del /s /q "%USERPROFILE%\.VirtualBox\*.tmp"
::------------ LIMPEZA DO Logi Options+ ---------------
echo Limpando cache do Logi Options+ ...
del /s /q "%LOCALAPPDATA%\LogiOptionsPlus\Cache\*.*"
::------------ LIMPEZA DO K-Lite Codec Pack ---------------
echo Limpando cache do K-Lite Codec Pack...
del /s /q "%ProgramFiles%\K-Lite Codec Pack\*temp*.*"
::------------ LIMPEZA DO Java ---------------
echo Limpando cache do Java...
del /s /q "%USERPROFILE%\AppData\LocalLow\Sun\Java\Deployment\cache\*.*"
::------------ LIMPEZA DO Git ---------------
echo Limpando cache do Git...
del /s /q "%USERPROFILE%\.git\*.*"
del /s /q "%USERPROFILE%\.config\git\*.*"
::------------ LIMPEZA DO Foxit PDF Reader ---------------
echo Limpando cache do Foxit PDF Reader...
del /s /q "%APPDATA%\Foxit Software\Foxit Reader\CrashRpt\*.*"
del /s /q "%APPDATA%\Foxit Software\Foxit Reader\Temp\*.*"
::------------ LIMPEZA DO DaVinci Resolve ---------------
echo Limpando cache do DaVinci Resolve...
del /s /q "%APPDATA%\Blackmagic Design\DaVinci Resolve\CacheClip\*.*"
::------------ LIMPEZA DO BCUninstaller ---------------
echo Limpando cache do BCUninstaller...
del /s /q "%LOCALAPPDATA%\BCUninstaller\temp\*.*"
::------------ LIMPEZA DO AnyDesk ---------------
echo Limpando cache do AnyDesk...
del /s /q "%APPDATA%\AnyDesk\*tmp*.*"
::------------ LIMPEZA DO AMD Software: Adrenalin Edition ---------------
echo Limpando cache do AMD Software...
del /s /q "%LOCALAPPDATA%\AMD\CN\Cache\*.*"
::------------ LIMPEZA DO ADB AppControl ---------------
echo Limpando cache do ADB AppControl...
del /s /q "%LOCALAPPDATA%\AdbAppControl\temp\*.*"
::------------ LIMPEZA DO 7-Zip ---------------
echo Limpando cache do 7-Zip...
del /s /q "%APPDATA%\7-Zip\temp\*.*"
::------------ LIMPEZA DO Spotify ---------------
echo Limpando cache do Spotify...
del /s /q "%LOCALAPPDATA%\Spotify\Storage\*.*"
del /s /q "%LOCALAPPDATA%\Spotify\Data\*.*"
::------------ LIMPEZA DO GitHub Desktop ---------------
echo Limpando cache do GitHub Desktop...
del /s /q "%APPDATA%\GitHub Desktop\Cache\*.*"
del /s /q "%USERPROFILE%\AppData\Local\GitHubDesktop\Cache\*.*"
::------------ LIMPEZA DO Bitwarden ---------------
echo Limpando cache do Bitwarden...
del /s /q "%APPDATA%\Bitwarden\Cache\*.*"
::------------ LIMPEZA DO Excel, PowerPoint, Word ---------------
echo Limpando cache do Excel PowerPoint  Word...
del /s /q "%APPDATA%\Microsoft\Excel\XLStart\*.*"
del /s /q "%APPDATA%\Microsoft\PowerPoint\*.*" 
del /s /q "%APPDATA%\Microsoft\Word\Startup\*.*"
::------------ LIMPEZA DO explorer.exe (Windows Explorer cache de ícones e miniaturas) ---------------
echo Limpando cache do Explorer...
del /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db"
del /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache_*.db"

if errorlevel 1 (
    echo Aviso: Alguns arquivos ou processos nao puderam ser limpos.
) else (
    echo Limpeza completa concluida!
)
pause
exit /b

:: ---------- REPARO ----------
:REPARO_MENU
cls
echo ==== REPARO AVANCADO ====
echo [1] Verificar integridade da imagem do Windows (DISM /CheckHealth)
echo [2] Scan detalhado da imagem (DISM /ScanHealth)
echo [3] Reparar componentes do Windows (DISM /RestoreHealth)
echo [4] Verificar e reparar arquivos do sistema (SFC /scannow)
echo [5] Reparo sequencial recomendado (DISM + SFC)
echo [0] Voltar
set /p "repopt=Escolha uma opcao: "
if "!repopt!"=="1" call :DISM_CheckHealth & goto REPARO_MENU
if "!repopt!"=="2" call :DISM_ScanHealth & goto REPARO_MENU
if "!repopt!"=="3" call :DISM_RestoreHealth & goto REPARO_MENU
if "!repopt!"=="4" call :SFC_ScanNow & goto REPARO_MENU
if "!repopt!"=="5" call :REPARO_SEQUENCIAL & goto REPARO_MENU
if "!repopt!"=="0" exit /b
goto REPARO_MENU

:DISM_CheckHealth
cls
echo Verificando integridade da imagem do Windows...
DISM /Online /Cleanup-Image /CheckHealth
if errorlevel 1 (
    echo Erro detectado na verificacao da integridade.
) else (
    echo Integridade verificada com sucesso.
)
pause
exit /b

:DISM_ScanHealth
cls
echo Escaneando a saude da imagem do Windows...
DISM /Online /Cleanup-Image /ScanHealth
if errorlevel 1 (
    echo Erros encontrados na saude da imagem.
) else (
    echo Saude da imagem verificada com sucesso.
)
pause
exit /b

:DISM_RestoreHealth
cls
echo Reparando componentes do Windows...
DISM /Online /Cleanup-Image /RestoreHealth
if errorlevel 1 (
    echo Falha na reparacao de componentes.
) else (
    echo Reparacao concluida com sucesso.
)
pause
exit /b

:SFC_ScanNow
cls
echo Verificando e reparando arquivos do sistema...
sfc /scannow
if errorlevel 1 (
    echo O utilitario SFC encontrou problemas ou falhou.
) else (
    echo Verificacao concluida com sucesso.
)
pause
exit /b

:REPARO_SEQUENCIAL
cls
echo Executando sequencia DISM ScanHealth, RestoreHealth e SFC...
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
echo Recomendado reiniciar o sistema apos o procedimento.
pause
exit /b

:: ---------- OTIMIZACAO ----------
:OTIMIZACAO_MENU
cls
echo ==== OTIMIZACOES DO WINDOWS ====
echo [1] Otimizacao SSD (TRIM e desativar defrag agendado)
echo [2] Otimizacao HDD (defrag tradicional)
echo [3] Otimizacao de Rede e Internet
echo [4] Otimizacao de Energia e Desempenho
echo [5] Otimizacao AMD Ryzen 5 3500U
echo [6] Otimizacao de Memoria RAM (limpeza cache/standby)
echo [7] Gerenciamento de Servicos
echo [8] Otimizacao de Inicializacao (programas no boot)
echo [9] Ajustes Visuais e Interface
echo [10] Protecao e Privacidade
echo [11] Otimizacao para Jogos
echo [12] Otimizacao Avancada de Rede
echo [13] Reverter todas as Otimizacoes
echo [0] Voltar
set /p "otopt=Escolha uma opcao: "
if "!otopt!"=="1" call :OTIMIZACAO_SSD & goto OTIMIZACAO_MENU
if "!otopt!"=="2" call :OTIMIZACAO_HDD & goto OTIMIZACAO_MENU
if "!otopt!"=="3" call :OTIMIZACAO_REDE & goto OTIMIZACAO_MENU
if "!otopt!"=="4" call :OTIMIZACAO_ENERGIA & goto OTIMIZACAO_MENU
if "!otopt!"=="5" call :OTIMIZACAO_RYZEN & goto OTIMIZACAO_MENU
if "!otopt!"=="6" call :OTIMIZACAO_RAM & goto OTIMIZACAO_MENU
if "!otopt!"=="7" call :GERENCIAS_SERVICOS & goto OTIMIZACAO_MENU
if "!otopt!"=="8" call :OTIMIZACAO_BOOT & goto OTIMIZACAO_MENU
if "!otopt!"=="9" call :AJUSTES_VISUAIS & goto OTIMIZACAO_MENU
if "!otopt!"=="10" call :PROTECAO_PRIVACIDADE & goto OTIMIZACAO_MENU
if "!otopt!"=="11" call :OTIMIZACAO_JOGOS & goto OTIMIZACAO_MENU
if "!otopt!"=="12" call :OTIMIZACAO_REDE_AVANCADA & goto OTIMIZACAO_MENU
if "!otopt!"=="13" call :REVERTENDO_OTIMIZACOES & goto OTIMIZACAO_MENU
if "!otopt!"=="0" exit /b
goto OTIMIZACAO_MENU

:OTIMIZACAO_SSD
cls
echo Executando otimizacao SSD...
fsutil behavior set DisableDeleteNotify 0
schtasks /Change /TN "Microsoft\\Windows\\Defrag\\ScheduledDefrag" /Disable >nul 2>&1
if errorlevel 1 (
    echo Falha ao desativar defrag agendado.
) else (
    echo Otimizacao SSD concluida.
)
pause
exit /b

:OTIMIZACAO_HDD
cls
echo Executando defragmentacao para HDD...
defrag C: /O
if errorlevel 1 (
    echo Erro ao executar defrag.
) else (
    echo Defragmentacao concluida.
)
pause
exit /b

:OTIMIZACAO_REDE
cls
echo Otimizando rede...
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
ipconfig /flushdns >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo Otimizacao de rede concluida.
pause
exit /b

:OTIMIZACAO_ENERGIA
cls
echo Otimizando energia e desempenho...
powercfg /setactive SCHEME_BALANCED >nul 2>&1
powercfg /change monitor-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
echo Otimizacao aplicada.
pause
exit /b

:OTIMIZACAO_RYZEN
cls
echo Aplicando plano de otimizacao para AMD Ryzen 5 3500U...
echo Coloque o arquivo RyzenOptimized.pow na mesma pasta e substitua <GUID> pelo correto antes de usar.
rem powercfg /import "%~dp0RyzenOptimized.pow"
rem powercfg /setactive <GUID>
pause
exit /b

:OTIMIZACAO_RAM
cls
echo Limpando cache de memoria RAM (limite de comando direto)...
echo Use ferramentas externas para limpeza profunda.
pause
exit /b

:GERENCIAS_SERVICOS
cls
echo Listando e desabilitando servicos nao essenciais (exemplo)...
sc stop Fax >nul 2>&1
sc config Fax start= disabled >nul 2>&1
echo Servicos desabilitados.
pause
exit /b

:OTIMIZACAO_BOOT
cls
echo Abrindo gerenciador de tarefas para controle de programas no boot...
start taskmgr
pause
exit /b

:AJUSTES_VISUAIS
cls
echo Ajustando visual para desempenho...
reg add "HKCU\\Control Panel\\Desktop\\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\\Software\\Microsoft\\Windows\\DWM" /v Composition /t REG_DWORD /d 0 /f >nul 2>&1
echo Ajustes aplicados.
pause
exit /b

:PROTECAO_PRIVACIDADE
cls
echo Desativando telemetria...
reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo Telemetria desativada.
pause
exit /b

:OTIMIZACAO_JOGOS
cls
echo Otimizacao para Jogos (manual)...
echo Desative processos nao essenciais e eleve prioridades manualmente se desejar.
pause
exit /b

:OTIMIZACAO_REDE_AVANCADA
cls
echo Otimizando parametros de rede avancados...
netsh interface tcp set global chimney=enabled >nul 2>&1
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global congestionprovider=ctcp >nul 2>&1
echo Otimizacao avancada aplicada.
pause
exit /b

:REVERTENDO_OTIMIZACOES
cls
echo Revertendo otimizacoes...
schtasks /Change /TN "Microsoft\\Windows\\Defrag\\ScheduledDefrag" /Enable >nul 2>&1
sc config Fax start= demand >nul 2>&1
sc start Fax >nul 2>&1
reg add "HKCU\\Control Panel\\Desktop\\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\\Software\\Microsoft\\Windows\\DWM" /v Composition /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f >nul 2>&1
echo Otimizacoes revertidas.
pause
exit /b

:: ---------- DRIVERS ----------
:DRIVERS_MENU
cls
echo ==== BACKUP E GERENCIAMENTO DE DRIVERS ====
echo [1] Backup dos drivers atuais
echo [2] Restaurar drivers do backup
echo [3] Desativar atualizacoes automaticas de drivers via Windows Update
echo [4] Verificar dispositivos com problema (Gerenciador de Dispositivos)
echo [5] Abrir Gerenciador de Dispositivos
echo [0] Voltar
set /p "dopt=Escolha uma opcao: "
if "!dopt!"=="1" call :BACKUP_DRIVERS & goto DRIVERS_MENU
if "!dopt!"=="2" call :RESTORE_DRIVERS & goto DRIVERS_MENU
if "!dopt!"=="3" call :DISABLE_AUTO_DRIVER_UPDATES & goto DRIVERS_MENU
if "!dopt!"=="4" call :OPEN_DEVICE_MANAGER & goto DRIVERS_MENU
if "!dopt!"=="5" call :OPEN_DEVICE_MANAGER & goto DRIVERS_MENU
if "!dopt!"=="0" exit /b
goto DRIVERS_MENU

:BACKUP_DRIVERS
cls
set "backupdir=%USERPROFILE%\Desktop\BackupDrivers"
if not exist "!backupdir!" mkdir "!backupdir!"
echo Exportando drivers para !backupdir!...
dism /online /export-driver /destination:"!backupdir!"
if errorlevel 1 (
    echo Falha no backup dos drivers.
) else (
    echo Backup concluido com sucesso.
)
pause
exit /b

:RESTORE_DRIVERS
cls
set "backupdir=%USERPROFILE%\Desktop\BackupDrivers"
if not exist "!backupdir!" (
    echo Pasta de backup nao encontrada: !backupdir!
    pause
    exit /b
)
echo Restaurando drivers da pasta !backupdir!...
pnputil /scan-devices
pnputil /add-driver "!backupdir!\*.inf" /subdirs /install
if errorlevel 1 (
    echo Falha na restauracao dos drivers.
) else (
    echo Restauracao concluida (reinicie se necessario).
)
pause
exit /b

:DISABLE_AUTO_DRIVER_UPDATES
cls
echo Desativando atualizacoes automaticas via Windows Update...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul 2>&1
if errorlevel 1 (
    echo Falha ao desativar atualizacoes automaticas.
) else (
    echo Atualizacoes de drivers desativadas.
)
pause
exit /b

:OPEN_DEVICE_MANAGER
cls
echo Abrindo Gerenciador de Dispositivos...
start devmgmt.msc
pause
exit /b

:: ---------- ATUALIZACOES ----------
:ATUALIZACOES_MENU
cls
echo ==== ATUALIZACOES DE PROGRAMAS ====
echo [1] Configurar Windows Update para atualizacoes de seguranca apenas
echo [2] Verificar atualizacoes via winget
echo [3] Verificar atualizacoes via chocolatey
echo [4] Verificar atualizacoes via winget e chocolatey juntos
echo [0] Voltar
set /p "aopt=Escolha uma opcao: "
if "!aopt!"=="1" call :CONFIG_WIN_UPDATE & goto ATUALIZACOES_MENU
if "!aopt!"=="2" call :CHECK_WINGET_UPDATES & goto ATUALIZACOES_MENU
if "!aopt!"=="3" call :CHECK_CHOCO_UPDATES & goto ATUALIZACOES_MENU
if "!aopt!"=="4" call :CHECK_ALL_UPDATES & goto ATUALIZACOES_MENU
if "!aopt!"=="0" exit /b
goto ATUALIZACOES_MENU

:CONFIG_WIN_UPDATE
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions" /t REG_DWORD /d 3 /f >nul 2>&1
echo Windows Update configurado para atualizacoes de seguranca apenas.
pause
exit /b

:CHECK_WINGET_UPDATES
cls
echo Verificando atualizacoes via winget...
winget upgrade
pause
exit /b

:CHECK_CHOCO_UPDATES
cls
echo Verificando atualizacoes via chocolatey...
choco outdated
pause
exit /b

:CHECK_ALL_UPDATES
cls
echo Verificando atualizacoes via winget e chocolatey...
echo --- Winget ---
winget upgrade
echo.
echo --- Chocolatey ---
choco outdated
pause
exit /b

:: ---------- FERRAMENTAS ----------
:FERRAMENTAS_MENU
cls
echo ==== FERRAMENTAS AVANCADAS ====
echo [1] Gerenciador de Tarefas Avancadas (Process Explorer)
echo [2] Editor de Registro
echo [3] Gerenciador de Dispositivos
echo [4] Visualizador de Eventos
echo [5] Limpar Cache DNS
echo [6] Abrir Monitor de Recursos
echo [7] Exibir uso CPU, RAM e Disco
echo [0] Voltar
set /p "fopt=Escolha uma opcao: "
if "!fopt!"=="1" call :PROCESS_EXPLORER & goto FERRAMENTAS_MENU
if "!fopt!"=="2" start regedit & goto FERRAMENTAS_MENU
if "!fopt!"=="3" start devmgmt.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="4" start eventvwr.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="5" call :FLUSH_DNS & goto FERRAMENTAS_MENU
if "!fopt!"=="6" start resmon.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="7" call :SHOW_RESOURCE_USAGE & goto FERRAMENTAS_MENU
if "!fopt!"=="0" exit /b
goto FERRAMENTAS_MENU

:PROCESS_EXPLORER
cls
if exist "%~dp0procexp.exe" (
    start "" "%~dp0procexp.exe"
) else (
    echo Process Explorer nao encontrado.
    echo Baixe em: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
)
pause
exit /b

:FLUSH_DNS
cls
ipconfig /flushdns >nul 2>&1
if errorlevel 1 (
    echo Falha ao limpar cache DNS.
) else (
    echo Cache DNS limpo com sucesso!
)
pause
exit /b

:SHOW_RESOURCE_USAGE
cls
echo Uso de CPU:
wmic cpu get loadpercentage
echo.
echo Memoria livre (KB):
wmic OS get FreePhysicalMemory /format:list
echo.
echo Processos:
tasklist /FO TABLE /NH
pause
exit /b

:: ---------- INSTALACOES ----------
:INSTALACOES_MENU
cls
echo ==== INSTALACAO DE PROGRAMAS ====
echo [1] Instalar programas via winget
echo [2] Instalar programas via chocolatey
echo [3] Baixar programas de terceiros (links)
echo [0] Voltar
set /p "iopt=Escolha uma opcao: "
if "!iopt!"=="1" call :WINGET_INSTALL & goto INSTALACOES_MENU
if "!iopt!"=="2" call :CHOCO_INSTALL & goto INSTALACOES_MENU
if "!iopt!"=="3" call :DOWNLOAD_LINKS & goto INSTALACOES_MENU
if "!iopt!"=="0" exit /b
goto INSTALACOES_MENU

:WINGET_INSTALL
cls
echo ==== Instalar via Winget ====
echo Escolha o programa:
echo 1. Google Chrome
echo 2. AnyDesk
echo 3. TeamViewer
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
echo 16. WSL (Ubuntu/Kali)
echo 17. PowerShell 7
echo 18. OnlyOffice
echo 19. OBS Studio
echo 20. Peazip
echo 21. Angry IP Scanner
echo 0. Voltar
set /p "wintopt=Escolha: "
if "!wintopt!"=="1" winget install Google.Chrome -e
if "!wintopt!"=="2" winget install AnyDeskSoftwareGmbH.AnyDesk -e
if "!wintopt!"=="3" winget install TeamViewer.TeamViewer -e
if "!wintopt!"=="4" winget install Bitwarden.Bitwarden -e
if "!wintopt!"=="5" winget install Foxit.FoxitReader -e
if "!wintopt!"=="6" winget install GIMP.GIMP -e
if "!wintopt!"=="7" winget install Notepad++.Notepad++ -e
if "!wintopt!"=="8" winget install Microsoft.VisualStudioCode -e
if "!wintopt!"=="9" winget install GitHub.GitHubDesktop -e
if "!wintopt!"=="10" winget install VideoLAN.VLC -e
if "!wintopt!"=="11" winget install Spotify.Spotify -e
if "!wintopt!"=="12" winget install 7zip.7zip -e
if "!wintopt!"=="13" winget install CodecGuide.K-LiteCodecPack.Mega -e
if "!wintopt!"=="14" winget install Oracle.JavaRuntimeEnvironment -e
if "!wintopt!"=="15" winget install Git.Git -e
if "!wintopt!"=="16" winget install Microsoft.WSL -e
if "!wintopt!"=="17" winget install Microsoft.PowerShell -e
if "!wintopt!"=="18" winget install ONLYOFFICE.DesktopEditors -e
if "!wintopt!"=="19" winget install OBSProject.OBSStudio -e
if "!wintopt!"=="20" winget install Giorgiotani.Peazip -e
if "!wintopt!"=="21" winget install angryziber.AngryIPScanner -e
if "!wintopt!"=="0" exit /b
pause
goto WINGET_INSTALL

:CHOCO_INSTALL
cls
echo ==== Instalar via Chocolatey ====
echo Escolha o programa:
echo 1. Google Chrome
echo 2. AnyDesk
echo 3. TeamViewer
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
set /p "chocopt=Escolha: "
if "!chocopt!"=="1" choco install googlechrome -y
if "!chocopt!"=="2" choco install anydesk -y
if "!chocopt!"=="3" choco install teamviewer -y
if "!chocopt!"=="4" choco install bitwarden -y
if "!chocopt!"=="5" choco install foxitreader -y
if "!chocopt!"=="6" choco install gimp -y
if "!chocopt!"=="7" choco install notepadplusplus -y
if "!chocopt!"=="8" choco install vscode -y
if "!chocopt!"=="9" choco install github-desktop -y
if "!chocopt!"=="10" choco install vlc -y
if "!chocopt!"=="11" choco install spotify -y
if "!chocopt!"=="12" choco install 7zip -y
if "!chocopt!"=="13" choco install k-litecodecpackmega -y
if "!chocopt!"=="14" choco install jre8 -y
if "!chocopt!"=="15" choco install git -y
if "!chocopt!"=="16" choco install wsl -y
if "!chocopt!"=="17" choco install powershell -y
if "!chocopt!"=="18" choco install onlyoffice -y
if "!chocopt!"=="19" choco install obs-studio -y
if "!chocopt!"=="20" choco install peazip -y
if "!chocopt!"=="21" choco install angryip -y
if "!chocopt!"=="0" exit /b
pause
goto CHOCO_INSTALL

:DOWNLOAD_LINKS
cls
echo ==== Downloads oficiais ====
echo 1. Free Download Manager - https://www.freedownloadmanager.org/pt/download.htm
echo 2. Office 2024 - https://terabox.com/s/1gHLymvkhNVN9RANV4LRU0w
echo 3. Ativador Office 2024 - https://terabox.com/s/1PTjkxwGlpnT69DdRSPDuUQ
echo 4. VirtualBox - https://www.virtualbox.org/wiki/Downloads
echo 5. Winrar + Ativador - https://terabox.com/s/17sQw7Taye19qrCpL6M4-DA
echo 6. ADB - Platform Tools - https://developer.android.com/tools/releases/platform-tools?hl=pt-br
echo 7. Bulk Crap Uninstaller - https://github.com/Klocman/Bulk-Crap-Uninstaller/releases
echo 8. Visual C++ Redistributable - https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/
echo 9. Windows Update Blocker - https://www.sordum.org/9470/windows-update-blocker-v1-8/
echo 10. DaVinci Resolve - https://www.computerbase.de/downloads/audio-und-video/davinci-resolve/
echo 11. OBS Studio - https://www.computerbase.de/downloads/audio-und-video/obs-studio/
echo 12. NextDNS - https://my.nextdns.io/login
echo 13. Kaspersky + VPN - https://www.kaspersky.com.br/premium
echo 14. RyTuneX - https://github.com/rayenghanmi/RyTuneX
echo 15. RustDesk - https://rustdesk.com/pt/
echo 16. WinUtil (ChrisTitus) - https://github.com/ChrisTitusTech/winutil
echo 17. CrapFixer - https://github.com/builtbybel/CrapFixer
echo 18. ADB APP CONTROL - https://adbappcontrol.com/en/
echo 19. Windows Memory Cleaner - https://github.com/IgorMundstein/WinMemoryCleaner
echo 20. Clean Tools Plus - https://github.com/braulioreis27/CleanTools-Plus
echo 21. Defender Control - https://www.sordum.org/9480/defender-control-v2-1/
echo 22. Driver Store Explorer - https://github.com/lostindark/DriverStoreExplorer
echo 23. OCCT - https://www.ocbase.com/download
echo 0. Voltar
echo =================================
set /p "dlopt=Escolha o link para abrir: "
if "!dlopt!"=="1" start https://www.freedownloadmanager.org/pt/download.htm
if "!dlopt!"=="2" start https://terabox.com/s/1gHLymvkhNVN9RANV4LRU0w
if "!dlopt!"=="3" start https://terabox.com/s/1PTjkxwGlpnT69DdRSPDuUQ
if "!dlopt!"=="4" start https://www.virtualbox.org/wiki/Downloads
if "!dlopt!"=="5" start https://terabox.com/s/17sQw7Taye19qrCpL6M4-DA
if "!dlopt!"=="6" start https://developer.android.com/tools/releases/platform-tools?hl=pt-br
if "!dlopt!"=="7" start https://github.com/Klocman/Bulk-Crap-Uninstaller/releases
if "!dlopt!"=="8" start https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/
if "!dlopt!"=="9" start https://www.sordum.org/9470/windows-update-blocker-v1-8/
if "!dlopt!"=="10" start https://www.computerbase.de/downloads/audio-und-video/davinci-resolve/
if "!dlopt!"=="11" start https://www.computerbase.de/downloads/audio-und-video/obs-studio/
if "!dlopt!"=="12" start https://my.nextdns.io/login
if "!dlopt!"=="13" start https://www.kaspersky.com.br/premium
if "!dlopt!"=="14" start https://github.com/rayenghanmi/RyTuneX
if "!dlopt!"=="15" start https://rustdesk.com/pt/
if "!dlopt!"=="16" start https://github.com/ChrisTitusTech/winutil
if "!dlopt!"=="17" start https://github.com/builtbybel/CrapFixer
if "!dlopt!"=="18" start https://adbappcontrol.com/en/
if "!dlopt!"=="19" start https://github.com/IgorMundstein/WinMemoryCleaner
if "!dlopt!"=="20" start https://github.com/braulioreis27/CleanTools-Plus
if "!dlopt!"=="21" start https://www.sordum.org/9480/defender-control-v2-1/
if "!dlopt!"=="22" start https://github.com/lostindark/DriverStoreExplorer
if "!dlopt!"=="23" start https://www.ocbase.com/download
if "!dlopt!"=="0" exit /b
goto DOWNLOAD_LINKS
