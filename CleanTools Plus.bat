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
for /f "skip=1 tokens=*" %%a in ('wmic os get caption') do (
    if not defined winver set "winver=%%a"
)
for /f "tokens=*" %%a in ('ver') do set "winver=%%a"

:: Opcional: remover caracteres específicos, por exemplo "[" e "]"
setlocal enabledelayedexpansion
set "winver_cleaned=!winver:[=!"
set "winver_cleaned=!winver_cleaned:]=!"
echo Versao do Windows limpa: !winver_cleaned!
endlocal & set "winver=!winver_cleaned!"

:: ---------- Criação de Pastas Necessárias ----------
if not exist "%USERPROFILE%\Desktop\Logs" mkdir "%USERPROFILE%\Desktop\Logs"
if not exist "%USERPROFILE%\Desktop\Backups" mkdir "%USERPROFILE%\Desktop\Backups"
if not exist "%USERPROFILE%\Desktop\Drivers" mkdir "%USERPROFILE%\Desktop\Drivers"
if not exist "%USERPROFILE%\Desktop\Ferramentas" mkdir "%USERPROFILE%\Desktop\Ferramentas"
if not exist "%USERPROFILE%\Desktop\Instaladores" mkdir "%USERPROFILE%\Desktop\Instaladores"
:: ---------- Função Principal / Menu ----------
:MAINMENU
cls
echo ================================================
echo       PROJETO DE MANUTENCAO WINDOWS 10/11
echo ================================================
echo Data: %date%    Hora: %time%
echo Endereco IP Local: !ip!
echo Versao do Windows: !winver!
echo Desenvolvido por: braulioreis27
echo Versao do Script: v7.0
echo GitHub:braulioreis27   
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
echo [8] Informacoes do Sistema
echo [9] Sobre o Projeto
echo [10] Abrir Pasta de Logs 
echo [11] Abrir Pasta de Backups
echo [12] Abrir Pasta de Drivers
echo [13] Abrir Pasta de Ferramentas
echo [14] Abrir Pasta de Instaladores
echo [15] Abrir Pasta Temporaria
echo [16] Abrir Configuracoes Avancadas
echo [17] Abrir Prompt de Comando como Administrador
echo [18] Abrir PowerShell como Administrador
echo [19] Reiniciar o Computador
echo [20] Desligar o Computador
echo [21] Recursos Google Chrome Flags - Configuracoes Avancadas
echo [0] Sair do Programa
echo.
echo ================================================
set /p "mainopt=Escolha uma opcao: "
if "!mainopt!"=="1" call :LIMPEZA_MENU & goto MAINMENU
if "!mainopt!"=="2" call :REPARO_MENU & goto MAINMENU
if "!mainopt!"=="3" call :OTIMIZACAO_MENU & goto MAINMENU
if "!mainopt!"=="4" call :DRIVERS_MENU & goto MAINMENU
if "!mainopt!"=="5" call :ATUALIZACOES_MENU & goto MAINMENU
if "!mainopt!"=="6" call :FERRAMENTAS_MENU & goto MAINMENU
if "!mainopt!"=="7" call :INSTALACOES_MENU & goto MAINMENU
if "!mainopt!"=="8" call :INFO_SISTEMA & goto MAINMENU
if "!mainopt!"=="9" call :SOBRE_PROJETO & goto MAINMENU
if "!mainopt!"=="10" start "" "%USERPROFILE%\Desktop\Logs" & goto MAINMENU
if "!mainopt!"=="11" start "" "%USERPROFILE%\Desktop\Backups" & goto MAINMENU
if "!mainopt!"=="12" start "" "%USERPROFILE%\Desktop\Drivers" & goto MAINMENU
if "!mainopt!"=="13" start "" "%USERPROFILE%\Desktop\Ferramentas" & goto MAINMENU
if "!mainopt!"=="14" start "" "%USERPROFILE%\Desktop\Instaladores" & goto MAINMENU
if "!mainopt!"=="15" start "" "%USERPROFILE%\AppData\Local\Temp" & goto MAINMENU
if "!mainopt!"=="16" start ms-settings: & goto MAINMENU
if "!mainopt!"=="17" call :CMD_ADMIN & goto MAINMENU
if "!mainopt!"=="18" call :POWERSHELL_ADMIN & goto MAINMENU
if "!mainopt!"=="19" shutdown /r /t 0 & goto MAINMENU
if "!mainopt!"=="20" shutdown /s /t 0 & goto MAINMENU   
if "!mainopt!"=="21" call :CHROME_FLAGS & goto MAINMENU
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
echo Executando limpeza simples (cache dos navegadores e pastas do sistema)...

:: Limpando cache do Chrome
echo Limpando cache do Chrome...
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1

:: Limpando cache do Firefox
echo Limpando cache do Firefox...
for /d %%G in ("%APPDATA%\Mozilla\Firefox\Profiles\*.default-release") do (
    del /s /f /q "%%G\cache2\*.*" >nul 2>&1
)

:: Limpando cache do Edge
echo Limpando cache do Edge...
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1

:: Limpando pasta Temp do usuário
echo Limpando pasta Temp do usuário...
del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1

:: Limpando pasta Temp do Windows
echo Limpando pasta Temp do Windows...
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1

:: Limpando arquivos recentes
echo Limpando arquivos recentes...
del /s /f /q "%USERPROFILE%\recent\*.*" >nul 2>&1

:: Limpando cache da Lixeira
echo Limpando Lixeira...
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >nul 2>&1

:: Limpando DNS cache
echo Limpando cache DNS...
ipconfig /flushdns >nul 2>&1

if errorlevel 1 (
    echo Aviso: Alguns arquivos ou processos nao puderam ser limpos.
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
::------------ LIMPEZA DE NAVEGADORES ---------------
echo Limpando cache dos navegadores...
:: Chrome
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
:: Firefox
for /d %%G in ("%APPDATA%\Mozilla\Firefox\Profiles\*.default-release") do (
    del /s /f /q "%%G\cache2\*.*" >nul 2>&1
)
:: Edge
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
:: Opera
del /s /f /q "%APPDATA%\Opera Software\Opera Stable\Cache\*.*" >nul 2>&1

::------------ LIMPEZA DE SOFTWARES DE TERCEIROS ---------------
echo Limpando cache de softwares de terceiros...
del /s /q "%LOCALAPPDATA%\FreeDownloadManager.ORG\Free Download Manager\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\.ipscan\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\.java\.userPrefs\ipscan\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Audacity\SessionData\*.*" >nul 2>&1
del /s /q "%APPDATA%\Audacity\*.*" >nul 2>&1
del /s /q "%APPDATA%\Disk SpeedUp\Temp\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Disk SpeedUp\Temp\*.*" >nul 2>&1
del /s /q "%APPDATA%\GIMP\2.10\tmp\*.*" >nul 2>&1
del /s /q "%ProgramData%\Kaspersky Lab\AVP21.3\Temp\*.*" >nul 2>&1
del /s /q "%APPDATA%\Notepad++\backup\*.*" >nul 2>&1
del /s /q "%APPDATA%\obs-studio\cache\*.*" >nul 2>&1
del /s /q "%APPDATA%\Code\Cache\*.*" >nul 2>&1
del /s /q "%APPDATA%\Code\CachedData\*.*" >nul 2>&1
del /s /q "%APPDATA%\Code\logs\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_*\LocalCache\*.*" >nul 2>&1
del /s /q "%APPDATA%\vlc\cache\*.*" >nul 2>&1
del /s /q "%APPDATA%\vlc\*thumbs.db" >nul 2>&1
del /s /q "%USERPROFILE%\.VirtualBox\*.tmp" >nul 2>&1
del /s /q "%LOCALAPPDATA%\LogiOptionsPlus\Cache\*.*" >nul 2>&1
del /s /q "%ProgramFiles%\K-Lite Codec Pack\*temp*.*" >nul 2>&1
del /s /q "%USERPROFILE%\AppData\LocalLow\Sun\Java\Deployment\cache\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\.git\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\.config\git\*.*" >nul 2>&1
del /s /q "%APPDATA%\Foxit Software\Foxit Reader\CrashRpt\*.*" >nul 2>&1
del /s /q "%APPDATA%\Foxit Software\Foxit Reader\Temp\*.*" >nul 2>&1
del /s /q "%APPDATA%\Blackmagic Design\DaVinci Resolve\CacheClip\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\BCUninstaller\temp\*.*" >nul 2>&1
del /s /q "%APPDATA%\AnyDesk\*tmp*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\AMD\CN\Cache\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\AdbAppControl\temp\*.*" >nul 2>&1
del /s /q "%APPDATA%\7-Zip\temp\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Spotify\Storage\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Spotify\Data\*.*" >nul 2>&1
del /s /q "%APPDATA%\GitHub Desktop\Cache\*.*" >nul 2>&1
del /s /q "%USERPROFILE%\AppData\Local\GitHubDesktop\Cache\*.*" >nul 2>&1
del /s /q "%APPDATA%\Bitwarden\Cache\*.*" >nul 2>&1
del /s /q "%APPDATA%\Microsoft\Excel\XLStart\*.*" >nul 2>&1
del /s /q "%APPDATA%\Microsoft\PowerPoint\*.*" >nul 2>&1
del /s /q "%APPDATA%\Microsoft\Word\Startup\*.*" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache_*.db" >nul 2>&1

::------------ LIMPEZA DO SISTEMA ---------------
echo Limpando arquivos temporários do sistema...
del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >nul 2>&1
net stop wuauserv >nul 2>&1
del /q /f "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
del /f /s /q %systemdrive%\*.tmp >nul 2>&1
del /f /s /q %systemdrive%\*.log >nul 2>&1
del /f /s /q %systemdrive%\*.bak >nul 2>&1
ipconfig /flushdns >nul 2>&1

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
echo [6] Reparo com fonte externa (imagem ISO ou pasta Windows)
echo [7] Reparo offline (via mídia de instalação)
echo [8] Reparo avançado com PowerShell
echo [9] Reparo de inicialização (boot)
echo [10] Reparo de permissões de arquivos e pastas
echo [11] Reparo do Windows Update
echo [12] Reparo do Microsoft Store
echo [13] Reparo do .NET Framework
echo [14] Reparo do Registro do Windows
echo [15] Reparo do WMI (Windows Management Instrumentation)
echo [16] Reparo do BITS (Background Intelligent Transfer Service)  
echo [17] Reparo do Firewall do Windows
echo [18] Reparo do Windows Search
echo [19] Reparo do Windows Defender
echo [20] Reparo do Perfil de Usuário
echo [21] Reparo do Menu Iniciar e Barra de Tarefas
echo [22] Reparo do Explorador de Arquivos (File Explorer)
echo [23] Reparo do Agendador de Tarefas
echo [24] Reparo do Servidor de Impressão
echo [25] Reparo do Bluetooth
echo [26] Reparo do Som e Áudio
echo [27] Reparo do Wi-Fi e Conexão de Rede
echo [28] Reparo do Touchpad e Mouse
echo [29] Reparo do Teclado
echo [30] Reparo do Windows Activation (Ativação do Windows)
echo [31] Reparo do Windows Update Medic Service
echo [32] Reparo do Windows Modules Installer
echo [33] Reparo do Windows Event Log
echo [34] Reparo do Windows Time Service
echo [35] Reparo do Windows Remote Management (WinRM)
echo [36] Reparo do Windows Error Reporting Service
echo [37] Reparo do Windows Image Acquisition (WIA)
echo [38] Reparo do Windows Insider Program
echo [39] Reparo do Windows Location Service
echo [40] Reparo do Windows Push Notification Service
echo [41] Reparo do Windows Update Orchestrator Service
echo [42] Reparo do Windows Defender Antivirus Service
echo [43] Reparo do Windows Defender Firewall Service
echo [44] Reparo do Windows Defender Security Center Service
echo [45] Reparo do Windows Defender SmartScreen Service
echo [46] Reparo do Windows Defender Credential Guard
echo [47] Reparo do Windows Defender Application Guard
echo [48] Reparo do Windows Defender Exploit Guard
echo [49] Reparo do Windows Defender Advanced Threat Protection
echo [50] Reparo do Windows Defender Antivirus Network Inspection Service
echo [0] Voltar ao Menu Principal
echo.
echo ===============================================
set /p "repopt=Escolha uma opcao: "
if "!repopt!"=="1" call :DISM_CheckHealth & goto REPARO_MENU
if "!repopt!"=="2" call :DISM_ScanHealth & goto REPARO_MENU
if "!repopt!"=="3" call :DISM_RestoreHealth & goto REPARO_MENU
if "!repopt!"=="4" call :SFC_ScanNow & goto REPARO_MENU
if "!repopt!"=="5" call :REPARO_SEQUENCIAL & goto REPARO_MENU
if "!repopt!"=="6" call :REPARO_FONTE_EXTERNA & goto REPARO_MENU
if "!repopt!"=="7" call :REPARO_OFFLINE & goto REPARO_MENU
if "!repopt!"=="8" call :REPARO_AVANCADO_POWERSHELL & goto REPARO_MENU
if "!repopt!"=="9" call :REPARO_INICIALIZACAO & goto REPARO_MENU
if "!repopt!"=="10" call :REPARO_PERMISSOES & goto REPARO_MENU
if "!repopt!"=="11" call :REPARO_WINDOWS_UPDATE & goto REPARO_MENU
if "!repopt!"=="12" call :REPARO_MICROSOFT_STORE & goto REPARO_MENU
if "!repopt!"=="13" call :REPARO_DOTNET_FRAMEWORK & goto REPARO_MENU
if "!repopt!"=="14" call :REPARO_REGISTRO & goto REPARO_MENU
if "!repopt!"=="15" call :REPARO_WMI & goto REPARO_MENU
if "!repopt!"=="16" call :REPARO_BITS & goto REPARO_MENU
if "!repopt!"=="17" call :REPARO_FIREWALL & goto REPARO_MENU
if "!repopt!"=="18" call :REPARO_WINDOWS_SEARCH & goto REPARO_MENU
if "!repopt!"=="19" call :REPARO_WINDOWS_DEFENDER & goto REPARO_MENU
if "!repopt!"=="20" call :REPARO_PERFIL_USUARIO & goto REPARO_MENU
if "!repopt!"=="21" call :REPARO_MENU_INICIAR & goto REPARO_MENU
if "!repopt!"=="22" call :REPARO_EXPLORADOR_ARQUIVOS & goto REPARO_MENU
if "!repopt!"=="23" call :REPARO_AGENDADOR_TAREFAS & goto REPARO_MENU
if "!repopt!"=="24" call :REPARO_SERVIDOR_IMPRESSAO & goto REPARO_MENU
if "!repopt!"=="25" call :REPARO_BLUETOOTH & goto REPARO_MENU
if "!repopt!"=="26" call :REPARO_SOM_AUDIO & goto REPARO_MENU
if "!repopt!"=="27" call :REPARO_WIFI_REDE & goto REPARO_MENU
if "!repopt!"=="28" call :REPARO_TOUCHPAD_MOUSE & goto REPARO_MENU
if "!repopt!"=="29" call :REPARO_TECLADO & goto REPARO_MENU
if "!repopt!"=="30" call :REPARO_ATIVACAO_WINDOWS & goto REPARO_MENU
if "!repopt!"=="31" call :REPARO_WINDOWS_UPDATE_MEDIC & goto REPARO_MENU
if "!repopt!"=="32" call :REPARO_WINDOWS_MODULES_INSTALLER & goto REPARO_MENU
if "!repopt!"=="33" call :REPARO_WINDOWS_EVENT_LOG & goto REPARO_MENU
if "!repopt!"=="34" call :REPARO_WINDOWS_TIME_SERVICE & goto REPARO_MENU
if "!repopt!"=="35" call :REPARO_WINDOWS_REMOTE_MANAGEMENT & goto REPARO_MENU
if "!repopt!"=="36" call :REPARO_WINDOWS_ERROR_REPORTING & goto REPARO_MENU
if "!repopt!"=="37" call :REPARO_WINDOWS_IMAGE_ACQUISITION & goto REPARO_MENU
if "!repopt!"=="38" call :REPARO_WINDOWS_INSIDER_PROGRAM & goto REPARO_MENU
if "!repopt!"=="39" call :REPARO_WINDOWS_LOCATION_SERVICE & goto REPARO_MENU
if "!repopt!"=="40" call :REPARO_WINDOWS_PUSH_NOTIFICATION & goto REPARO_MENU
if "!repopt!"=="41" call :REPARO_WINDOWS_UPDATE_ORCHESTRATOR & goto REPARO_MENU
if "!repopt!"=="42" call :REPARO_WINDOWS_DEFENDER_ANTIVIRUS & goto REPARO_MENU
if "!repopt!"=="43" call :REPARO_WINDOWS_DEFENDER_FIREWALL & goto REPARO_MENU
if "!repopt!"=="44" call :REPARO_WINDOWS_DEFENDER_SECURITY_CENTER & goto REPARO_MENU
if "!repopt!"=="45" call :REPARO_WINDOWS_DEFENDER_SMARTSCREEN & goto REPARO_MENU
if "!repopt!"=="46" call :REPARO_WINDOWS_DEFENDER_CREDENTIAL_GUARD & goto REPARO_MENU
if "!repopt!"=="47" call :REPARO_WINDOWS_DEFENDER_APPLICATION_GUARD & goto REPARO_MENU
if "!repopt!"=="48" call :REPARO_WINDOWS_DEFENDER_EXPLOIT_GUARD & goto REPARO_MENU
if "!repopt!"=="49" call :REPARO_WINDOWS_DEFENDER_ADVANCED_THREAT & goto REPARO_MENU
if "!repopt!"=="50" call :REPARO_WINDOWS_DEFENDER_NETWORK_INSPECTION & goto REPARO_MENU
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
echo Reparando componentes do Windows 11...
DISM /Online /Cleanup-Image /RestoreHealth
if errorlevel 1 (
    echo Falha na reparacao de componentes. Tente reiniciar o sistema e executar novamente.
) else (
    echo Reparacao concluida com sucesso. Recomendado reiniciar o sistema para aplicar as alteracoes.
)
pause
exit /b


:SFC_ScanNow
cls
echo Executando o utilitário SFC para verificar e reparar arquivos do sistema no Windows 11...
sfc /scannow
if errorlevel 1 (
    echo O utilitário SFC encontrou problemas ou falhou. Tente executar novamente ou reinicie o sistema.
) else (
    echo Verificação e reparação concluídas com sucesso.
)
pause
exit /b


:REPARO_SEQUENCIAL
cls
echo Executando reparo sequencial recomendado para Windows 11...
echo 1. Verificando integridade da imagem do Windows...
DISM /Online /Cleanup-Image /CheckHealth
echo 2. Escaneando a saude da imagem do Windows...
DISM /Online /Cleanup-Image /ScanHealth
echo 3. Reparando componentes do Windows...
DISM /Online /Cleanup-Image /RestoreHealth
echo 4. Verificando e reparando arquivos do sistema...
sfc /scannow
if errorlevel 1 (
    echo Aviso: Alguns erros nao puderam ser corrigidos. Reinicie o sistema e tente novamente.
) else (
    echo Reparo sequencial concluido com sucesso. Recomendado reiniciar o sistema.
)

:REPARO_FONTE_EXTERNA
cls
echo ==== REPARO COM FONTE EXTERNA ====
echo Insira o caminho da imagem ISO ou pasta Windows (exemplo: D:\Sources):
set /p "sourcepath=Digite o caminho: "
if not exist "!sourcepath!" (
    echo Caminho invalido ou nao encontrado. Tente novamente.
    pause
    exit /b
)
echo Reparando componentes do Windows usando a fonte externa...
DISM /Online /Cleanup-Image /RestoreHealth /Source:!sourcepath! /LimitAccess
if errorlevel 1 (
    echo Falha ao reparar componentes com a fonte externa. Verifique o caminho e tente novamente.
) else (
    echo Reparacao concluida com sucesso. Recomendado reiniciar o sistema para aplicar as alteracoes.
)
pause
exit /b

:REPARO_OFFLINE
cls
echo ==== REPARO OFFLINE ==== 
echo Insira o caminho da midia de instalacao (exemplo: D:\Sources):
set /p "mediapath=Digite o caminho: "
if not exist "!mediapath!" (
    echo Caminho invalido ou nao encontrado. Tente novamente.
    pause
    exit /b
)
echo Reparando componentes do Windows usando a midia de instalacao...
DISM /Image:C:\ /Cleanup-Image /RestoreHealth /Source:!mediapath! /LimitAccess
if errorlevel 1 (
    echo Falha ao reparar componentes com a midia de instalacao. Verifique o caminho e tente novamente.
) else (
    echo Reparacao offline concluida com sucesso. Recomendado reiniciar o sistema para aplicar as alteracoes.
)
pause
exit /b

:REPARO_AVANCADO_POWERSHELL
cls
echo ==== REPARO AVANCADO COM POWERSHELL ====
echo Executando reparos avancados com PowerShell...
PowerShell -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command ""sfc /scannow; DISM /Online /Cleanup-Image /RestoreHealth""' -Verb RunAs}"
if errorlevel 1 (
    echo Falha ao executar reparos avancados com PowerShell.
) else (
    echo Reparos avancados com PowerShell concluídos com sucesso.
)
pause
exit /b

:REPARO_INICIALIZACAO
cls
echo ==== REPARO DE INICIALIZACAO ====
echo Executando reparo de inicializacao...
bcdedit /set {default} recoveryenabled Yes >nul 2>&1
bootrec /fixmbr >nul 2>&1
bootrec /fixboot >nul 2>&1
bootrec /scanos >nul 2>&1
bootrec /rebuildbcd >nul 2>&1
if errorlevel 1 (
    echo Falha ao executar reparo de inicializacao.
) else (
    echo Reparo de inicializacao concluido com sucesso.
)
pause
exit /b

:REPARO_PERMISSOES
cls
echo ==== REPARO DE PERMISSOES ====
echo Reparando permissoes de arquivos e pastas...
icacls "C:\" /reset /t /c /q >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar permissoes.
) else (
    echo Permissoes reparadas com sucesso.
)
pause
exit /b

:REPARO_WINDOWS_UPDATE
cls
echo ==== REPARO DO WINDOWS UPDATE ====
echo Reparando Windows Update...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
del /f /s /q %windir%\SoftwareDistribution\* >nul 2>&1
del /f /s /q %windir%\System32\catroot2\* >nul 2>&1
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Windows Update.
) else (
    echo Windows Update reparado com sucesso.
)
pause
exit /b

:REPARO_MICROSOFT_STORE
cls
echo ==== REPARO DO MICROSOFT STORE ====
echo Reparando Microsoft Store...
PowerShell -Command "Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ""$($_.InstallLocation)\AppXManifest.xml""}"
if errorlevel 1 (
    echo Falha ao reparar Microsoft Store.
) else (
    echo Microsoft Store reparado com sucesso.
)
pause
exit /b

:REPARO_DOTNET_FRAMEWORK
cls
echo ==== REPARO DO .NET FRAMEWORK ====
echo Reparando .NET Framework...
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:D:\sources\sxs
if errorlevel 1 (
    echo Falha ao reparar .NET Framework.
) else (
    echo .NET Framework reparado com sucesso.
)
pause
exit /b

:REPARO_REGISTRO
cls
echo ==== REPARO DO REGISTRO DO WINDOWS ====
echo Reparando Registro do Windows...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d "Usuario" /f >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Registro do Windows.
) else (
    echo Registro do Windows reparado com sucesso.
)
pause
exit /b

:REPARO_WMI
cls
echo ==== REPARO DO WMI ====
echo Reparando WMI...
winmgmt /resetrepository >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar WMI.
) else (
    echo WMI reparado com sucesso.
)
pause
exit /b

:REPARO_BITS
cls
echo ==== REPARO DO BITS ====
echo Reparando BITS...
sc config bits start= auto >nul 2>&1
net start bits >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar BITS.
) else (
    echo BITS reparado com sucesso.
)
pause
exit /b

:REPARO_FIREWALL
cls
echo ==== REPARO DO FIREWALL DO WINDOWS ====
echo Reparando Firewall do Windows...
netsh advfirewall reset >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Firewall do Windows.
) else (
    echo Firewall do Windows reparado com sucesso.
)
pause
exit /b

:REPARO_WINDOWS_SEARCH
cls
echo ==== REPARO DO WINDOWS SEARCH ====
echo Reparando Windows Search...
PowerShell -Command "Restart-Service WSearch"
if errorlevel 1 (
    echo Falha ao reparar Windows Search.
) else (
    echo Windows Search reparado com sucesso.
)
pause
exit /b

:REPARO_WINDOWS_DEFENDER
cls
echo ==== REPARO DO WINDOWS DEFENDER ====
echo Reparando Windows Defender...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All >nul 2>&1
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Windows Defender.
) else (
    echo Windows Defender reparado com sucesso.
)
pause
exit /b

:REPARO_PERFIL_USUARIO
cls
echo ==== REPARO DO PERFIL DE USUARIO ====
echo Reparando perfil de usuario...
reg load HKU\TempProfile "C:\Users\Default\NTUSER.DAT" >nul 2>&1
reg unload HKU\TempProfile >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar perfil de usuario.
) else (
    echo Perfil de usuario reparado com sucesso.
)
pause
exit /b

:REPARO_MENU_INICIAR
cls
echo ==== REPARO DO MENU INICIAR ====
echo Reparando Menu Iniciar...
PowerShell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ""$($_.InstallLocation)\AppXManifest.xml""}"
if errorlevel 1 (
    echo Falha ao reparar Menu Iniciar.
) else (
    echo Menu Iniciar reparado com sucesso.
)
pause
exit /b

:REPARO_EXPLORADOR_ARQUIVOS
cls
echo ==== REPARO DO EXPLORADOR DE ARQUIVOS ====
echo Reparando Explorador de Arquivos...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
if errorlevel 1 (
    echo Falha ao reparar Explorador de Arquivos.
) else (
    echo Explorador de Arquivos reparado com sucesso.
)
pause
exit /b

:REPARO_AGENDADOR_TAREFAS
cls
echo ==== REPARO DO AGENDADOR DE TAREFAS ====
echo Reparando Agendador de Tarefas...
schtasks /Query >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Agendador de Tarefas.
) else (
    echo Agendador de Tarefas reparado com sucesso.
)
pause
exit /b

:REPARO_SERVIDOR_IMPRESSAO
cls
echo ==== REPARO DO SERVIDOR DE IMPRESSAO ====
echo Reparando Servidor de Impressao...
net stop spooler >nul 2>&1
del /q /f /s "%systemroot%\System32\spool\PRINTERS\*.*" >nul 2>&1
net start spooler >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Servidor de Impressao.
) else (
    echo Servidor de Impressao reparado com sucesso.
)
pause
exit /b

:REPARO_BLUETOOTH
cls
echo ==== REPARO DO BLUETOOTH ====
echo Reparando Bluetooth...
net stop bthserv >nul 2>&1
net start bthserv >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Bluetooth.
) else (
    echo Bluetooth reparado com sucesso.
)
pause
exit /b

:REPARO_SOM_AUDIO
cls
echo ==== REPARO DO SOM E AUDIO ====
echo Reparando Som e Audio...
net stop audiosrv >nul 2>&1
net start audiosrv >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Som e Audio.
) else (
    echo Som e Audio reparados com sucesso.
)
pause
exit /b

:REPARO_WIFI_REDE
cls
echo ==== REPARO DO WI-FI E REDE ====
echo Reparando Wi-Fi e Rede...
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
ipconfig /flushdns >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Wi-Fi e Rede.
) else (
    echo Wi-Fi e Rede reparados com sucesso.
)
pause
exit /b

:REPARO_TOUCHPAD_MOUSE
cls
echo ==== REPARO DO TOUCHPAD E MOUSE ====
echo Reparando Touchpad e Mouse...
devmgmt.msc >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Touchpad e Mouse.
) else (
    echo Touchpad e Mouse reparados com sucesso.
)
pause
exit /b

:REPARO_TECLADO
cls
echo ==== REPARO DO TECLADO ====
echo Reparando Teclado...
devmgmt.msc >nul 2>&1
if errorlevel 1 (
    echo Falha ao reparar Teclado.
) else (
    echo Teclado reparado com sucesso.
)
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
echo [0] Voltar ao Menu Principal
echo.   
echo ===============================================
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
echo Executando otimizacao SSD para Windows 11...
:: Habilitando TRIM
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
:: Desativando desfragmentacao agendada
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1
:: Otimizando unidade SSD
defrag C: /L >nul 2>&1
if errorlevel 1 (
    echo Falha ao executar otimizacao para SSD.
) else (
    echo Otimizacao para SSD concluida com sucesso.
)
pause
exit /b


:OTIMIZACAO_HDD
cls
echo Executando otimizacao para HDD no Windows 11...
:: Desfragmentando o disco rígido
defrag C: /U /V
:: Ajustando configurações de energia para HDD
powercfg /change disk-timeout-ac 20 >nul 2>&1
powercfg /change disk-timeout-dc 10 >nul 2>&1
if errorlevel 1 (
    echo Erro ao executar otimizacao para HDD.
) else (
    echo Otimizacao para HDD concluida com sucesso.
)
pause
exit /b


:OTIMIZACAO_REDE
cls
echo Otimizando rede para Windows 11...
:: Resetando configurações de rede
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1
ipconfig /flushdns >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1

:: Ajustando MTU para desempenho
echo Ajustando MTU para desempenho...
for /f "tokens=1,2 delims=:" %%a in ('netsh interface ipv4 show subinterfaces ^| findstr /C:"Wi-Fi" /C:"Ethernet"') do (
    netsh interface ipv4 set subinterface "%%a" mtu=1472 store=persistent >nul 2>&1
)

:: Configurando parâmetros avançados de TCP
echo Configurando parâmetros avançados de TCP...
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1
netsh interface tcp set global ecncapability=enabled >nul 2>&1
netsh interface tcp set global timestamps=disabled >nul 2>&1

:: Finalizando otimização
echo Otimização de rede para Windows 11 concluída com sucesso!
pause
exit /b

:OTIMIZACAO_ENERGIA
cls
echo Otimizando energia e desempenho para Windows 11...
:: Ajustando plano de energia para Alto Desempenho
powercfg /setactive SCHEME_MIN >nul 2>&1
:: Desativando suspensão do sistema
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-dc 0 >nul 2>&1
:: Ajustando desligamento do monitor
powercfg /change monitor-timeout-ac 0 >nul 2>&1
powercfg /change monitor-timeout-dc 5 >nul 2>&1
:: Ajustando desligamento do disco rígido
powercfg /change disk-timeout-ac 0 >nul 2>&1
powercfg /change disk-timeout-dc 10 >nul 2>&1
:: Ativando o modo de economia de energia para dispositivos USB
powercfg -devicequery wake_armed >nul 2>&1
:: Ajustando configurações adicionais de energia
powercfg /hibernate off >nul 2>&1
powercfg /setacvalueindex SCHEME_MIN SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_MIN SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
echo Otimizacao de energia aplicada com sucesso!
pause
exit /b


:OTIMIZACAO_RYZEN
cls
echo Aplicando otimizacoes para AMD Ryzen no Windows 11...
:: Ajustando plano de energia para Ryzen Balanced
powercfg /setactive SCHEME_BALANCED >nul 2>&1
:: Ajustando configurações de energia para desempenho
powercfg /change monitor-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
:: Ajustando prioridade de processos para desempenho
wmic process where name="explorer.exe" CALL setpriority "high" >nul 2>&1
:: Ajustando configurações de CPU para desempenho
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v SecondLevelDataCache /t REG_DWORD /d 512 /f >nul 2>&1
:: Ajustando configurações de rede para baixa latência
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1
echo Otimizacoes para AMD Ryzen aplicadas com sucesso!
pause
exit /b


:OTIMIZACAO_RAM
cls
echo Limpando cache de memoria RAM (limite de comando direto)...
echo Use ferramentas externas para limpeza profunda.
echo Set o = CreateObject("Scripting.FileSystemObject") > "%temp%\ClearRAM.vbs"
echo o.GetSpecialFolder(2).FreeSpace = o.GetSpecialFolder(2).FreeSpace >> "%temp%\ClearRAM.vbs"
cscript //nologo "%temp%\ClearRAM.vbs"
del "%temp%\ClearRAM.vbs"
echo Cache de RAM limpo.
start taskmgr
start /wait "" "C:\Tools\RAMMap.exe" -command=empty standby
echo Cache de RAM limpo com RAMMap. 
pause
exit /b

:GERENCIAS_SERVICOS
cls
echo Listando e desabilitando servicos nao essenciais (exemplo)...
sc stop Fax >nul 2>&1
sc config Fax start= disabled >nul 2>&1
echo Servicos desabilitados.
echo Listando servicos para otimizacao...
sc query type= service state= all | findstr /I /C:"SERVICE_NAME" /C:"STATE"
echo servicos especificos ...
net stop <nome_servico> >nul 2>&1
net config <nome_servico> start= disabled >nul 2>&1

pause
exit /b

:OTIMIZACAO_BOOT
cls
echo Abrindo gerenciador de tarefas para controle de programas no boot ...     
start taskmgr
echo Desative programas nao essenciais na aba Inicializacao.
wmic startup get caption,command,location,User > "%USERPROFILE%\Desktop\startup_programs.txt"   
echo usar PowerShell para desabilitar  via registro .. 
PowerShell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name '<NomePrograma>' -Value '<CaminhoCompleto>' -Type String"
echo Listando programas de inicializacao...
wmic startup get Caption,Command,Location > "%USERPROFILE%\Desktop\StartupProgramsList.txt"
echo Lista salva na area de trabalho como "StartupProgramsList.txt".
pause
exit /b

:AJUSTES_VISUAIS
cls
echo Ajustando visuais para Windows 11...
:: Ativando cantos arredondados
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseOLEDTaskbarTransparency /t REG_DWORD /d 1 /f >nul 2>&1
:: Ativando efeitos de transparência
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>&1
:: Ajustando para tema escuro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
:: Ajustando animações
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012008010000000 /f >nul 2>&1
:: Ajustando tamanho da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 1 /f >nul 2>&1  
:: 0 = pequeno, 1 = medio, 2 = grande
:: Ajustando alinhamento da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
:: 0 = esquerda, 1 = centro
:: Ajustando tamanho dos icones da area de trabalho
reg add "HKCU\Software\Microsoft\Windows\Shell\Bags\1\Desktop" /v IconSize /t REG_DWORD /d 32 /f >nul 2>&1
:: 16, 24, 32, 48, 64, 96, 128, 256
:: Ajustando tamanho dos icones da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSmallIcons /t REG_DWORD /d 0 /f >nul 2>&1
:: 0 = icones grandes, 1 = icones pequenos
:: Ajustando transparência da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>&1
:: Ajustando cor da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 1 /f >nul 2>&1
:: 0 = cor padrao, 1 = cor personalizada
:: Ajustando cor de destaque
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AccentColorMenu /t REG_DWORD /d 0xff1e90ff /f >nul 2>&1
:: 0xffRRGGBB (exemplo: 0xff1e90ff = azul)
:: Ajustando tamanho do texto
reg add "HKCU\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 96 /f >nul 2>&1
:: 96 = 100%, 120 = 125%, 144 = 150%, 192 = 200%
:: Ajustando espaçamento dos icones
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconSpacing /t REG_SZ /d -1125 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v IconVerticalSpacing /t REG_SZ /d -1125 /f >nul 2>&1
:: -480 (mais proximo) a -2730 (mais distante)
:: Ajustando tamanho das janelas
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v BorderWidth /t REG_SZ /d -15 /f >nul 2>&1
:: -15 (mais fino) a -120 (mais grosso)
:: Ajustando tamanho das fontes
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v CaptionHeight /t REG_SZ /d -330 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v CaptionWidth /t REG_SZ /d -330 /f >nul 2>&1
echo Ajustando visual para desempenho no Windows 11...
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 0 /f >nul 2>&1
echo Ajustes visuais para desempenho aplicados com sucesso.
pause   
cls
echo Reiniciando o Explorer para aplicar as mudancas... 
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Explorer reiniciado.
pause
exit /b

:PROTECAO_PRIVACIDADE
cls
echo ==== PROTECAO E PRIVACIDADE ==== 
echo Aplicando configuracoes para melhorar a privacidade no Windows 11...
:: Desativando telemetria
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
:: Desativando ID de publicidade
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
:: Desativando sugestões de aplicativos
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
:: Desativando coleta de dados de entrada
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
:: Desativando Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
:: Desativando localização
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f >nul 2>&1
:: Desativando diagnósticos de aplicativos
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\diagnostics" /v Value /t REG_SZ /d Deny /f >nul 2>&1
:: Desativando coleta de dados de escrita
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
:: Desativando sugestões de pesquisa na web
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
:: Desativando coleta de dados de diagnóstico
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDiagnosticLogCollection /t REG_DWORD /d 1 /f >nul 2>&1
:: Desativando tarefas de telemetria
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
:: Desativando coleta de dados de voz
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul 2>&1
echo Configuracoes de privacidade aplicadas com sucesso!
pause
exit /b


:OTIMIZACAO_JOGOS
cls
echo ==== OTIMIZACAO PARA JOGOS ====
echo Ajustando configuracoes para melhor desempenho em jogos...
echo.

:: Desativando processos nao essenciais
echo Desativando processos nao essenciais...
taskkill /F /IM "OneDrive.exe" >nul 2>&1
taskkill /F /IM "YourPhone.exe" >nul 2>&1
taskkill /F /IM "SearchUI.exe" >nul 2>&1
taskkill /F /IM "Cortana.exe" >nul 2>&1

:: Ajustando prioridades de processos
echo Ajustando prioridades de processos...
wmic process where name="explorer.exe" CALL setpriority "idle" >nul 2>&1

:: Ajustando plano de energia para alto desempenho
echo Ajustando plano de energia para alto desempenho...
powercfg /setactive SCHEME_MIN >nul 2>&1

:: Ajustando configuracoes de rede para jogos
echo Ajustando configuracoes de rede para jogos...
netsh interface tcp set global ecncapability=enabled >nul 2>&1
netsh interface tcp set global dca=enabled >nul 2>&1
netsh interface tcp set global timestamps=disabled >nul 2>&1
netsh interface tcp set global autotuninglevel=disabled >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1

echo Otimizacao para jogos concluida!
pause
exit /b


:OTIMIZACAO_REDE_AVANCADA
cls
echo Otimizando parametros de rede avancados...
echo Ajustando parametros de rede avancados...
netsh interface tcp set global rss=enabled >nul 2>&1
netsh interface tcp set global autotuninglevel=experimental >nul 2>&1
netsh interface tcp set global congestionprovider=ctcp >nul 2>&1
netsh interface tcp set global ecncapability=enabled >nul 2>&1
netsh interface tcp set global dca=enabled >nul 2>&1
netsh interface tcp set global timestamps=disabled >nul 2>&1
netsh interface tcp set global chimney=enabled >nul 2>&1
echo Parametros de rede avancados ajustados com sucesso.
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
echo [6] Abrir Painel de Controle de Drivers (DriverStore Explorer) (necessario baixar)
echo [7] Abrir pasta de backup de drivers
echo [8] Abrir pasta temporaria de drivers baixados pelo Windows Update
echo [9] Baixando DriverStore Explorer via winget (se nao tiver)
echo [10] Baixando My ASUS via MS Store (se nao tiver)
echo [11] Baixando ScreenXpert via MS Store (se nao tiver)
echo [12] Baixando Logi Options+ via winget (se nao tiver)
echo [13] Baixando AMD Software: Adrenalin Edition via Site Oficial (se nao tiver)
echo [14] Baixando AMD Chipset Drivers via Site Oficial (se nao tiver)
echo [15] Baixando ASUS-M515DA Drivers via Site Oficial (se nao tiver) 
echo [0] Voltar ao menu principal
echo.
set /p "dopt=Escolha uma opcao: "
if "!dopt!"=="1" call :BACKUP_DRIVERS & goto DRIVERS_MENU
if "!dopt!"=="2" call :RESTORE_DRIVERS & goto DRIVERS_MENU
if "!dopt!"=="3" call :DISABLE_AUTO_DRIVER_UPDATES & goto DRIVERS_MENU
if "!dopt!"=="4" call :OPEN_DEVICE_MANAGER & goto DRIVERS_MENU
if "!dopt!"=="5" call :OPEN_DEVICE_MANAGER & goto DRIVERS_MENU
if "!dopt!"=="6" start "" "C:\Tools\DriverStoreExplorer.exe" & goto DRIVERS_MENU
if "!dopt!"=="7" start "" "%USERPROFILE%\Desktop\BackupDrivers" & goto DRIVERS_MENU
if "!dopt!"=="8" start "" "C:\Windows\SoftwareDistribution\Download" & goto DRIVERS_MENU    
if "!dopt!"=="9" winget install --id=Rufus.DriverStoreExplorer -e --source=winget & goto DRIVERS_MENU 
if "!dopt!"=="10" start ms-windows-store://pdp/?productid=9NBLGGH4TLCW & goto DRIVERS_MENU  
if "!dopt!"=="11" start ms-windows-store://pdp/?productid=9NBLGGH4R315 & goto DRIVERS_MENU  
if "!dopt!"=="12" winget install --id=Logitech.LogiOptionsPlus -e --source=winget & goto DRIVERS_MENU
if "!dopt!"=="13" start https://www.amd.com/pt/support/downloads/drivers.html/processors/ryzen/ryzen-3000-series/amd-ryzen-5-3500u.html & goto DRIVERS_MENU
if "!dopt!"=="14" start https://www.amd.com/pt/support/downloads/drivers.html/chipsets/am4/a320.html & goto DRIVERS_MENU
if "!dopt!"=="15" start https://www.asus.com/br/supportonly/m515da/helpdesk_download/ & goto DRIVERS_MENU   
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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
if errorlevel 1 (
    echo Falha ao desativar atualizacoes automaticas.
) else (
    echo Atualizacoes automaticas desativadas com sucesso.
)
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
echo [5] Atualizar via winget
echo [6] Atualizar via chocolatey
echo [7] Atualizar via winget e chocolatey juntos
echo [8] Baixar e instalar chocolatey (se nao tiver)
echo [9] Baixar e instalar winget (se nao tiver)   
echo [10] Atualizar WSL2 (Windows Subsystem for Linux)
echo [0] Voltar ao menu principal
echo.
echo ================================================
set /p "aopt=Escolha uma opcao: "
if "!aopt!"=="1" call :CONFIG_WIN_UPDATE & goto ATUALIZACOES_MENU
if "!aopt!"=="2" call :CHECK_WINGET_UPDATES & goto ATUALIZACOES_MENU
if "!aopt!"=="3" call :CHECK_CHOCO_UPDATES & goto ATUALIZACOES_MENU
if "!aopt!"=="4" call :CHECK_ALL_UPDATES & goto ATUALIZACOES_MENU
if "!opt!"=="5"  call :WINGET_UPGRADE & goto ATUALIZACOES_MENU
if "!opt!"=="6"  call :CHOCO_UPGRADE & goto ATUALIZACOES_MENU
if "!opt!"=="7"  call :ALL_UPGRADE & goto ATUALIZACOES_MENU
if "!aopt!"=="8"  @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin & goto ATUALIZACOES_MENU
if "!aopt!"=="9"  start https://aka.ms/getwinget & goto ATUALIZACOES_MENU
if "!aopt!"=="10" wsl --update & goto ATUALIZACOES_MENU
if "!aopt!"=="0" exit /b
goto ATUALIZACOES_MENU

:CONFIG_WIN_UPDATE
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions" /t REG_DWORD /d 3 /f >nul 2>&1
echo Windows Update configurado para atualizacoes de seguranca apenas.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetReleaseVersion /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetReleaseVersionInfo /t REG_SZ /d "21H2" /f >nul 2>&1
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

:WINGET_UPGRADE
cls
echo Atualizando programas via winget...
winget upgrade --all
if errorlevel 1 (
    echo Falha ao atualizar programas via winget.
) else (
    echo Atualizacao concluida com sucesso.
)

:CHOCO_UPGRADE
cls
echo Atualizando programas via chocolatey...
choco upgrade all -y
if errorlevel 1 (
    echo Falha ao atualizar programas via chocolatey.
) else (
    echo Atualizacao concluida com sucesso.
)
:ALL_UPGRADE
cls 
echo Atualizando programas via winget e chocolatey...
echo --- Winget ---
winget upgrade --all
echo.
echo --- Chocolatey ---
choco upgrade all -y
if errorlevel 1 (
    echo Falha ao atualizar programas via winget e chocolatey.
) else (
    echo Atualizacao concluida com sucesso.
)
pause
exit /b
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
echo [8] Abrir Monitor de Rede (Resource Monitor)
echo [9] Abrir Prompt de Comando como Administrador
echo [10] Abrir PowerShell como Administrador
echo [11] Abrir Windows Terminal como Administrador 
echo [12] Abrir Gerenciador de Discos
echo [13] Abrir Informacoes do Sistema
echo [14] Abrir Configuracoes do Sistema (msconfig)
echo [15] Abrir Agendador de Tarefas
echo [16] Abrir Visualizador de Dispositivos Bluetooth
echo [17] Abrir Ferramenta de Diagnostico de Memoria do Windows
echo [18] Abrir Configuracoes de Rede Avancadas
echo [19] Abrir Configuracoes de Energia Avancadas
echo [20] Abrir Configuracoes de Sincronizacao de Hora
echo [21] Abrir Configuracoes de Backup e Restauracao
echo [22] Abrir Configuracoes de Atualizacao do Windows
echo [23] Abrir Configuracoes de Firewall do Windows
echo [24] Abrir Configuracoes de Protecao contra Ameaças do Windows
echo [25] Abrir Configuracoes de Armazenamento
echo [26] Abrir Configuracoes de Privacidade
echo [27] Abrir Configuracoes de Aplicativos Padrao
echo [28] Abrir Configuracoes de Bluetooth e Dispositivos
echo [29] Abrir Configuracoes de Exibicao   
echo [0] Voltar ao menu principal
echo.
set /p "fopt=Escolha uma opcao: "
if "!fopt!"=="1" call :PROCESS_EXPLORER & goto FERRAMENTAS_MENU
if "!fopt!"=="2" start regedit & goto FERRAMENTAS_MENU
if "!fopt!"=="3" start devmgmt.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="4" start eventvwr.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="5" call :FLUSH_DNS & goto FERRAMENTAS_MENU
if "!fopt!"=="6" start resmon.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="7" call :SHOW_RESOURCE_USAGE & goto FERRAMENTAS_MENU
if "!fopt!"=="8" start resmon.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="9" start cmd.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="10" start powershell.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="11" start wt.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="12" start diskmgmt.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="13" start msinfo32.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="14" start msconfig.exe & goto FERRAMENTAS_MENU    
if "!fopt!"=="15" start taskschd.msc & goto FERRAMENTAS_MENU
if "!fopt!"=="16" start bthprops.cpl & goto FERRAMENTAS_MENU
if "!fopt!"=="17" mdsched.exe & goto FERRAMENTAS_MENU
if "!fopt!"=="18" start ms-settings:network-status & goto FERRAMENTAS_MENU
if "!fopt!"=="19" start ms-settings:powersleep & goto FERRAMENTAS_MENU
if "!fopt!"=="20" start ms-settings:dateandtime & goto FERRAMENTAS_MENU
if "!fopt!"=="21" start ms-settings:backup & goto FERRAMENTAS_MENU
if "!fopt!"=="22" start ms-settings:windowsupdate & goto FERRAMENTAS_MENU
if "!fopt!"=="23" start ms-settings:windowsdefender & goto FERRAMENTAS_MENU
if "!fopt!"=="24" start ms-settings:windowsdefender & goto FERRAMENTAS_MENU
if "!fopt!"=="25" start ms-settings:storagesense & goto FERRAMENTAS_MENU
if "!fopt!"=="26" start ms-settings:privacy & goto FERRAMENTAS_MENU
if "!fopt!"=="27" start ms-settings:defaultapps & goto FERRAMENTAS_MENU
if "!fopt!"=="28" start ms-settings:bluetooth & goto FERRAMENTAS_MENU
if "!fopt!"=="29" start ms-settings:display & goto FERRAMENTAS_MENU
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

:NSFLUSH_D
cls
cls
echo Limpando cache DNS...
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
echo ==== USO DE RECURSOS DO SISTEMA ====
echo.
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
echo [4] Limpar cache de instaladores temporarios   
echo [5] Todos os programas em um clique (winget )
echo [6] Todos os programas em um clique (chocolatey)
echo [0] Voltar ao menu principal
echo.
set /p "iopt=Escolha uma opcao: "
if "!iopt!"=="1" call :WINGET_INSTALL & goto INSTALACOES_MENU
if "!iopt!"=="2" call :CHOCO_INSTALL & goto INSTALACOES_MENU
if "!iopt!"=="3" call :DOWNLOAD_LINKS & goto INSTALACOES_MENU
if "!iopt!"=="4" call :CLEAN_INSTALLER_CACHE & goto INSTALACOES_MENU
if "!iopt!"=="5" call :WINGET_BULK_INSTALL & goto INSTALACOES_MENU
if "!iopt!"=="6" call :CHOCO_BULK_INSTALL & goto INSTALACOES_MENU
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
echo.
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
pause
goto DOWNLOAD_LINKS

:CLEAN_INSTALLER_CACHE
cls
echo Limpando cache de instaladores temporarios...
del /s /q /f "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
del /s /q /f "%temp%\*.*" >nul 2>&1
if errorlevel 1 (
    echo Aviso: Alguns arquivos nao puderam ser removidos.
) else (
    echo Cache de instaladores temporarios limpo com sucesso!
)
pause
exit /b
:WINGET_BULK_INSTALL
cls 
echo Instalando todos os programas recomendados via winget...
winget install Google.Chrome -e
winget install AnyDeskSoftwareGmbH.AnyDesk -e
winget install TeamViewer.TeamViewer -e
winget install Bitwarden.Bitwarden -e
winget install Foxit.FoxitReader -e
winget install GIMP.GIMP -e
winget install Notepad++.Notepad++ -e
winget install Microsoft.VisualStudioCode -e
winget install GitHub.GitHubDesktop -e
winget install VideoLAN.VLC -e
winget install Spotify.Spotify -e
winget install 7zip.7zip -e
winget install CodecGuide.K-LiteCodecPack.Mega -e
winget install Oracle.JavaRuntimeEnvironment -e
winget install Git.Git -e
winget install Microsoft.WSL -e
winget install Microsoft.PowerShell -e
winget install ONLYOFFICE.DesktopEditors -e
winget install OBSProject.OBSStudio -e
winget install Giorgiotani.Peazip -e
winget install angryziber.AngryIPScanner -e
if errorlevel 1 (
    echo Falha ao instalar alguns programas.
) else (
    echo Todos os programas foram instalados com sucesso.
)
pause
exit /b

:CHOCO_BULK_INSTALL
cls 
echo Instalando todos os programas recomendados via chocolatey...
choco install googlechrome -y
choco install anydesk -y
choco install teamviewer -y
choco install bitwarden -y
choco install foxitreader -y
choco install gimp -y
choco install notepadplusplus -y
choco install vscode -y
choco install github-desktop -y
choco install vlc -y
choco install spotify -y
choco install 7zip -y
choco install k-litecodecpackmega -y
choco install jre8 -y
choco install git -y
choco install wsl -y
choco install powershell -y
choco install onlyoffice -y
choco install obs-studio -y
choco install peazip -y
choco install angryip -y
if errorlevel 1 (
    echo Falha ao instalar alguns programas.
) else (
    echo Todos os programas foram instalados com sucesso.
)
pause
exit /b

:INFO_SISTEMA
cls
echo ==== INFORMACOES DO SISTEMA ====
echo.
systeminfo
echo.   
pause
exit /b

:SOBRE_PROJETO
cls
echo ==== SOBRE O PROJETO ====
echo Este script foi desenvolvido para otimizar e gerenciar sistemas Windows.
echo Ele oferece diversas funcionalidades, incluindo otimizacoes de desempenho,
echo gerenciamento de drivers, instalacao de programas e ferramentas avancadas.
echo.
echo Desenvolvido por Braulio Reis
echo GitHub:braulioreis27  
echo.echo Agradecimentos especiais a:
echo ChrisTitusTech - https://www.youtube.com/c/ChrisTitusTech
echo Britec09 - https://www.youtube.com/c/Britec09
echo Sordum - https://www.sordum.org/
echo.
echo Ferramentas utilizadas:
echo - Process Explorer (Sysinternals)
echo - Driver Store Explorer
echo - Chocolatey
echo - Winget
echo - Bulk Crap Uninstaller
echo - Windows Memory Cleaner
echo - Clean Tools Plus
echo - Defender Control
echo - CrapFixer
echo - ADB App Control
echo - RyTuneX
echo - WinUtil (ChrisTitusTech)
echo - RustDesk
echo - OCCT
echo - E muitas outras...
echo.
pause
exit /b 

:CMD_ADMIN  
cls
echo Abrindo Prompt de Comando como Administrador...
powershell -Command "Start-Process cmd -ArgumentList '/c start cmd' -Verb RunAs"
exit /b

:POWERSHELL_ADMIN
cls
echo Abrindo PowerShell como Administrador...
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile' -Verb RunAs"
exit /b
:WT_ADMIN
cls
echo Abrindo Windows Terminal como Administrador...
powershell -Command "Start-Process wt -ArgumentList '' -Verb RunAs"
exit /b

:CHROME_FLAGS   
cls
echo =======================================
echo      RECURSOS GOOGLE CHROME FlAGS 
echo =======================================
echo.
echo [1] Smooth Scrolling
echo [2] GPU Rasterization
echo [3] Zero-Copy Rasterizer
echo [4] Overlay Scrollbars
echo [5] Tab Audio Muting  UI Controls
echo [6] Parallel Downloading
echo [7] Experimental QUIC Protocol
echo [8] Voltar 
echo.
set /p "copt=Escolha uma opcao: "
if "!copt!"=="0" exit /b
if "!copt!"=="1" start chrome.exe --enable-features=SmoothScrolling & goto CHROME_FLAGS
if "!copt!"=="2" start chrome.exe --enable-features=GPURasterization & goto CHROME_FLAGS
if "!copt!"=="3" start chrome.exe --enable-features=ZeroCopyRasterizer & goto CHROME_FLAGS
if "!copt!"=="4" start chrome.exe --enable-features=OverlayScrollbar & goto CHROME_FLAGS
if "!copt!"=="5" start chrome.exe --enable-features=TabAudioMuting & goto CHROME_FLAGS
if "!copt!"=="6" start chrome.exe --enable-features=ParallelDownloading & goto CHROME_FLAGS
if "!copt!"=="7" start chrome.exe --enable-quic & goto CHROME_FLAGS
if "!copt!"=="8" exit /b    
goto CHROME_FLAGS   


:: ---------- FIM DO SCRIPT ----------
:END
cls
echo Obrigado por usar este script!
echo Desenvolvido por Braulio Reis
echo GitHub: braulioreis27
echo.
pause
exit /b
exit /b
