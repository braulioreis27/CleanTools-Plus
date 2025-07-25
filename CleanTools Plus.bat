@echo off
:: Script de Manutenção Completo para Windows
:: Combina limpeza, otimização, reparo e atualização em um único menu
:: Versão 2.2 - Agosto 2023
:: Adicionado: Gerenciamento de Armazenamento Reservado e melhorias em redes/impressão

:menu
mode con: cols=80 lines=30
color 0A
cls
echo ==================================================
echo        	 MANUTENCAO COMPLETA DO WINDOWS 
echo ==================================================
echo.
echo 1 - Limpeza do Sistema
echo 2 - Reparo do Sistema
echo 3 - Otimizacoes do Windows
echo 4 - Atualizacoes de Programas
echo 5 - Manutencao de Rede
echo 6 - Manutencao de Impressao
echo 7 - Todas as Operacoes (Completo)
echo 8 - Configuracoes
echo 9 - Sair
echo.
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="1" goto limpeza
if "%opcao%"=="2" goto reparo
if "%opcao%"=="3" goto otimizacao
if "%opcao%"=="4" goto atualizacao
if "%opcao%"=="5" goto manutencao_rede
if "%opcao%"=="6" goto manutencao_impressao
if "%opcao%"=="7" goto completo
if "%opcao%"=="8" goto configuracoes
if "%opcao%"=="9" exit
echo Opcao invalida! Tente novamente.
pause
goto menu

:limpeza
cls
echo ==================================================
echo        	 LIMPEZA DO SISTEMA 
echo ==================================================
echo.
echo 1 - Limpeza Basica (Rapida)
echo 2 - Limpeza Completa
echo 3 - Limpeza Avancada (Baboo)
echo 4 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha o tipo de limpeza: 

if "%escolha%"=="1" goto limpeza_basica
if "%escolha%"=="2" goto limpeza_completa
if "%escolha%"=="3" goto limpeza_avancada
if "%escolha%"=="4" goto menu
echo Opcao invalida!
pause
goto limpeza

:limpeza_basica
echo.
echo  Executando limpeza basica...
:: Limpeza de arquivos temporários
del /s /q %temp%\*.*
rd /s /q %temp%
md %temp%
del /s /q /f C:\Windows\Temp\*.*
del /s /q /f C:\Users\%USERNAME%\AppData\Local\Temp\*.*

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force"

:: Limpeza de cache de navegadores
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default-release\cache2\entries\*.*"

echo.
echo  Limpeza basica concluida!
pause
goto limpeza

:limpeza_completa
echo.
echo  Executando limpeza completa do sistema...

:: Limpeza de arquivos temporários
del /s /q %temp%\*.*
rd /s /q %temp%
md %temp%
del /s /q /f C:\Windows\Temp\*.*
del /s /q /f C:\Users\%USERNAME%\AppData\Local\Temp\*.*
del /s /q /f C:\Users\Public\Temp\*.*

:: Limpeza de cache do Windows Update
net stop wuauserv
rd /s /q C:\Windows\SoftwareDistribution\Download
net start wuauserv

:: Limpeza de arquivos de cache do sistema
del /s /q C:\Windows\Prefetch\*.*
del /s /q /f C:\Windows\System32\LogFiles\*.*

:: Limpeza de logs
del /s /q C:\Windows\Logs\CBS\*.log
del /s /q C:\Windows\Logs\DISM\*.log
del /s /q C:\Windows\System32\winevt\Logs\*.evtx
del /s /q C:\Users\%USERNAME%\AppData\Local\Microsoft\OneDrive\logs\*.log

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force"

:: Limpeza de cache de navegadores
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Profile*\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Profile*\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Vivaldi\User Data\Default\Cache\*.*"
del /s /q /f "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default-release\cache2\entries\*.*"

:: Limpeza de cache de programas
del /s /q /f "%LOCALAPPDATA%\GitHubDesktop\Cache\*.*"
del /s /q /f "%APPDATA%\Spotify\Storage\*.*"
del /s /q /f "%APPDATA%\vlc\cache\*.*"
del /s /q /f "%APPDATA%\TeamViewer\*.*"
del /s /q /f "%APPDATA%\Bitwarden\Cache\*.*"
del /s /q /f "%APPDATA%\Microsoft\Excel\*.tmp"
del /s /q /f "%APPDATA%\Microsoft\Word\*.tmp"
del /s /q /f "%APPDATA%\VMware\*.*"

:: Limpeza de disco
cleanmgr /sagerun:1

echo.
echo  Limpeza completa concluida!
pause
goto limpeza

:limpeza_avancada
echo.
echo  Executando limpeza avancada (Baboo)...
call :baboo_clean
echo.
echo  Limpeza avancada concluida!
pause
goto limpeza

:reparo
cls
echo ==================================================
echo        	 REPARO DO SISTEMA 
echo ==================================================
echo.
echo  Verificando integridade dos arquivos do sistema...
sfc /scannow
echo.
echo  Verificando a saúde da imagem do sistema...
dism /Online /Cleanup-Image /ScanHealth
dism /Online /Cleanup-Image /CheckHealth
echo.
echo  Restaurando imagem do sistema...
dism /Online /Cleanup-Image /RestoreHealth
echo.
echo  Executando verificação e otimização do disco...
chkdsk /f /r
echo.
echo  Reparando componentes do Windows Update...
dism /Online /Cleanup-Image /StartComponentCleanup
echo.
echo  Corrigindo permissões de arquivos do sistema...
powershell -Command "secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose"

echo.
echo  Reparo concluído! Reinicie o sistema para aplicar todas as correções.
pause
goto menu

:otimizacao
cls
echo ==================================================
echo        	 OTIMIZACAO DO WINDOWS 
echo ==================================================
echo.
echo 1 - Otimizacoes Basicas
echo 2 - Otimizacoes de Desempenho
echo 3 - Otimizacoes de Rede
echo 4 - Gerenciar Armazenamento Reservado
echo 5 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha o tipo de otimizacao: 

if "%escolha%"=="1" goto otimizacao_basica
if "%escolha%"=="2" goto otimizacao_desempenho
if "%escolha%"=="3" goto otimizacao_rede
if "%escolha%"=="4" goto gerenciar_armazenamento_reservado
if "%escolha%"=="5" goto menu
echo Opcao invalida!
pause
goto otimizacao

:otimizacao_basica
echo.
echo  Aplicando otimizacoes basicas...

:: Acelera menus
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f

:: Reduz tempo de resposta para aplicativos travados
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 2000 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f

:: Acelera desligamento
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f

:: Desativa relatórios de erro
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

:: Reinicia o Explorer para aplicar mudanças
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo  Otimizacoes basicas aplicadas!
pause
goto otimizacao

:otimizacao_desempenho
echo.
echo  Aplicando otimizacoes de desempenho...

:: Configura plano de energia para Alto Desempenho
powercfg /s SCHEME_MIN

:: Desativa efeitos visuais
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuAnimation /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f

:: Remove sombra de janelas
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f

:: Otimizações para SSD
fstype | find "NTFS" && (fsutil behavior set DisableDeleteNotify 0)
wmic diskdrive where "MediaType='Fixed hard disk media'" set WriteCacheEnabled=true
wmic diskdrive where "MediaType='Fixed hard disk media'" set WriteCacheType=1

:: Desativa serviços desnecessários
sc config DiagTrack start= disabled
sc config dmwappushservice start= disabled
sc stop DiagTrack
sc stop dmwappushservice

echo.
echo  Otimizacoes de desempenho aplicadas!
pause
goto otimizacao

:otimizacao_rede
echo.
echo  Aplicando otimizacoes de rede...

:: Melhora desempenho da rede
netsh interface tcp set global autotuninglevel=normal
netsh interface tcp set global rss=enabled
netsh int tcp set global chimney=enabled

:: Redefinição de configuração de rede
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns

echo.
echo  Otimizacoes de rede aplicadas!
pause
goto otimizacao

:gerenciar_armazenamento_reservado
cls
echo ==================================================
echo         GERENCIAR ARMAZENAMENTO RESERVADO 
echo ==================================================
echo.
echo 1 - Verificar status do Armazenamento Reservado
echo 2 - Habilitar Armazenamento Reservado
echo 3 - Desabilitar Armazenamento Reservado
echo 4 - Voltar ao Menu de Otimizacao
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto verificar_armazenamento_reservado
if "%escolha%"=="2" goto habilitar_armazenamento_reservado
if "%escolha%"=="3" goto desabilitar_armazenamento_reservado
if "%escolha%"=="4" goto otimizacao
echo Opcao invalida!
pause
goto gerenciar_armazenamento_reservado

:verificar_armazenamento_reservado
echo.
echo  Verificando status do Armazenamento Reservado...
DISM /Online /Get-ReservedStorageState
echo.
pause
goto gerenciar_armazenamento_reservado

:habilitar_armazenamento_reservado
echo.
echo  Habilitando Armazenamento Reservado...
DISM /Online /Set-ReservedStorageState /State:Enabled
echo.
echo  Armazenamento Reservado habilitado!
pause
goto gerenciar_armazenamento_reservado

:desabilitar_armazenamento_reservado
echo.
echo  Desabilitando Armazenamento Reservado...
Dism /Online /Set-ReservedStorageState /State:Disabled
echo.
echo  Armazenamento Reservado desabilitado!
pause
goto gerenciar_armazenamento_reservado

:atualizacao
cls
echo ==================================================
echo        	 ATUALIZACOES DE PROGRAMAS 
echo ==================================================
echo.
echo 1 - Instalar Winget e Chocolatey
echo 2 - Atualizar todos os programas
echo 3 - Atualizar apenas Winget
echo 4 - Atualizar apenas Chocolatey
echo 5 - Atualizar Windows Update
echo 6 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto instalar_gerenciadores
if "%escolha%"=="2" goto atualizar_tudo
if "%escolha%"=="3" goto atualizar_winget
if "%escolha%"=="4" goto atualizar_choco
if "%escolha%"=="5" goto atualizar_windows
if "%escolha%"=="6" goto menu
echo Opcao invalida!
pause
goto atualizacao

:instalar_gerenciadores
echo.
echo  Verificando e instalando Winget...
where winget >nul 2>&1 || (
    echo Instalando Winget...
    powershell -Command "Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile winget.appxbundle"
    powershell -Command "Add-AppxPackage winget.appxbundle"
)

echo  Verificando e instalando Chocolatey...
where choco >nul 2>&1 || (
    echo Instalando Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
)

echo.
echo  Instalação concluída!
pause
goto atualizacao

:atualizar_tudo
echo.
echo  Atualizando todos os programas...

where winget >nul 2>&1 && winget upgrade --all --silent || echo  Winget não encontrado, pulando etapa.
where choco >nul 2>&1 && choco upgrade all -y || echo  Chocolatey não encontrado, pulando etapa.
powershell -Command "Start-Process powershell -ArgumentList '-Command Install-WindowsUpdate -AcceptAll -AutoReboot' -Verb RunAs"

echo.
echo  Atualização concluída!
pause
goto atualizacao

:atualizar_winget
echo.
echo  Atualizando programas via Winget...
where winget >nul 2>&1 && winget upgrade --all --silent || echo  Winget não encontrado!
echo.
echo  Atualização concluída!
pause
goto atualizacao

:atualizar_choco
echo.
echo  Atualizando programas via Chocolatey...
where choco >nul 2>&1 && choco upgrade all -y || echo  Chocolatey não encontrado!
echo.
echo  Atualização concluída!
pause
goto atualizacao

:atualizar_windows
echo.
echo  Executando Windows Update...
powershell -Command "Start-Process powershell -ArgumentList '-Command Install-WindowsUpdate -AcceptAll -AutoReboot' -Verb RunAs"
echo.
echo  Atualização concluída!
pause
goto atualizacao

:manutencao_rede
cls
echo ==================================================
echo        	 MANUTENCAO DE REDE AVANCADA 
echo ==================================================
echo.
echo 1 - Limpar Cache DNS e Resetar TCP/IP
echo 2 - Verificar Configuracao de Rede
echo 3 - Testar Conexao com Internet
echo 4 - Solucionar Problemas de Rede
echo 5 - Verificar Portas Abertas
echo 6 - Verificar Rota para um Site
echo 7 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto limpar_cache_rede
if "%escolha%"=="2" goto verificar_config_rede
if "%escolha%"=="3" goto testar_conexao
if "%escolha%"=="4" goto solucionar_problemas_rede
if "%escolha%"=="5" goto verificar_portas
if "%escolha%"=="6" goto verificar_rota
if "%escolha%"=="7" goto menu
echo Opcao invalida!
pause
goto manutencao_rede

:limpar_cache_rede
echo.
echo  Limpando cache DNS e resetando configurações de rede...
ipconfig /flushdns
ipconfig /registerdns
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
echo.
echo  Cache de rede limpo e configurações resetadas!
pause
goto manutencao_rede

:verificar_config_rede
echo.
echo  Verificando configuração de rede atual...
echo.
echo === Configuração IP ===
ipconfig /all
echo.
echo === Rota de Rede ===
route print
echo.
echo === DNS Configurado ===
netsh interface ip show dnsservers
echo.
pause
goto manutencao_rede

:testar_conexao
echo.
set /p site=Digite o site para testar (ex: google.com): 
echo.
echo  Testando conexão com %site%...
ping -n 4 %site%
echo.
echo  Testando resolução DNS...
nslookup %site%
echo.
echo  Testes concluídos!
pause
goto manutencao_rede

:solucionar_problemas_rede
echo.
echo  Executando diagnóstico de rede...
netsh winsock reset catalog
netsh int ipv4 reset reset.log
netsh int ipv6 reset reset.log
netsh interface tcp set global autotuninglevel=restricted
echo.
echo  Verificando problemas comuns...
powershell -Command "Test-NetConnection -ComputerName google.com -Port 80"
echo.
echo  Diagnóstico concluído!
pause
goto manutencao_rede

:verificar_portas
echo.
set /p port=Digite a porta para verificar (ex: 80): 
echo.
echo  Verificando porta %port%...
netstat -ano | find ":%port%"
echo.
echo  Verificação concluída!
pause
goto manutencao_rede

:verificar_rota
echo.
set /p site=Digite o site para verificar a rota (ex: google.com): 
echo.
echo  Traçando rota para %site%...
tracert %site%
echo.
echo  Rota traçada!
pause
goto manutencao_rede

:manutencao_impressao
cls
echo ==================================================
echo        	 MANUTENCAO DE IMPRESSAO 
echo ==================================================
echo.
echo 1 - Limpar Cache de Impressão
echo 2 - Reiniciar Serviço de Impressão
echo 3 - Desativar Serviço de Impressão
echo 4 - Ativar Serviço de Impressão
echo 5 - Listar Impressoras Instaladas
echo 6 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto limpar_cache_impressao
if "%escolha%"=="2" goto reiniciar_spooler
if "%escolha%"=="3" goto desativar_spooler
if "%escolha%"=="4" goto ativar_spooler
if "%escolha%"=="5" goto listar_impressoras
if "%escolha%"=="6" goto menu
echo Opcao invalida!
pause
goto manutencao_impressao

:limpar_cache_impressao
echo.
echo  Parando serviço de spooler de impressão...
net stop spooler
echo.
echo  Limpando arquivos de cache de impressão...
del /q /f /s "%systemroot%\system32\spool\printers\*.*"
echo.
echo  Iniciando serviço de spooler de impressão...
net start spooler
echo.
echo  Cache de impressão limpo com sucesso!
pause
goto manutencao_impressao

:reiniciar_spooler
echo.
echo  Reiniciando serviço de spooler de impressão...
net stop spooler
net start spooler
echo.
echo  Serviço de impressão reiniciado com sucesso!
pause
goto manutencao_impressao

:desativar_spooler
echo.
echo  Desativando serviço de spooler de impressão...
sc config spooler start= disabled
net stop spooler
echo.
echo  Serviço de impressão desativado!
pause
goto manutencao_impressao

:ativar_spooler
echo.
echo  Ativando serviço de spooler de impressão...
sc config spooler start= auto
net start spooler
echo.
echo  Serviço de impressão ativado!
pause
goto manutencao_impressao

:listar_impressoras
echo.
echo  Impressoras instaladas no sistema:
echo.
wmic printer get name,portname,default,workoffline
echo.
pause
goto manutencao_impressao

:completo
cls
echo ==================================================
echo        	 MANUTENCAO COMPLETA EM ANDAMENTO 
echo ==================================================
echo.
echo Esta operacao pode demorar varios minutos...
echo.
echo  Etapa 1/6: Limpeza do Sistema...
call :limpeza_completa
echo.
echo  Etapa 2/6: Reparo do Sistema...
call :reparo
echo.
echo  Etapa 3/6: Otimizacoes do Sistema...
call :otimizacao_desempenho
call :otimizacao_rede
echo.
echo  Etapa 4/6: Gerenciamento de Armazenamento...
call :desabilitar_armazenamento_reservado
echo.
echo  Etapa 5/6: Manutenção de Impressão...
call :limpar_cache_impressao
echo.
echo  Etapa 6/6: Atualizacoes...
call :atualizar_tudo
echo.
echo  MANUTENCAO COMPLETA CONCLUIDA!
echo Reinicie o computador para aplicar todas as alteracoes.
pause
goto menu

:configuracoes
cls
echo ==================================================
echo        	 CONFIGURACOES DO SCRIPT 
echo ==================================================
echo.
echo 1 - Ativar/Desativar Reinicio Automatico
echo 2 - Ativar/Desativar Modo Verbose
echo 3 - Restaurar Configuracoes Padrao
echo 4 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto toggle_reboot
if "%escolha%"=="2" goto toggle_verbose
if "%escolha%"=="3" goto reset_config
if "%escolha%"=="4" goto menu
echo Opcao invalida!
pause
goto configuracoes

:toggle_reboot
if exist "reboot_enabled.txt" (
    del "reboot_enabled.txt"
    echo Reinicio automatico DESATIVADO.
) else (
    echo. > "reboot_enabled.txt"
    echo Reinicio automatico ATIVADO.
)
pause
goto configuracoes

:toggle_verbose
if exist "verbose_enabled.txt" (
    del "verbose_enabled.txt"
    echo Modo verbose DESATIVADO.
) else (
    echo. > "verbose_enabled.txt"
    echo Modo verbose ATIVADO.
)
pause
goto configuracoes

:reset_config
if exist "reboot_enabled.txt" del "reboot_enabled.txt"
if exist "verbose_enabled.txt" del "verbose_enabled.txt"
echo Configuracoes restauradas para os valores padrao.
pause
goto configuracoes

:baboo_clean
REM ******************** LIXEIRA ********************
del c:\$recycle.bin\* /s /q
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >$null
del $null

REM ******************** PASTA TEMP DOS USUÁRIOS ********************
for /d %%F in (C:\Users\*) do (Powershell.exe Remove-Item -Path "%%F\AppData\Local\Temp\*" -Recurse -Force)
for /d %%F in (C:\Users\*) do type nul >"%%F\Appdata\Local\Temp\vazio.txt"
for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Temp\ %%F\AppData\Local\Temp\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Temp\vazio.txt

REM ******************** WINDOWS TEMP ********************
del c:\Windows\Temp\* /s /q
type nul > c:\Windows\Temp\vazio.txt
robocopy c:\Windows\Temp c:\Windows\Temp /s /move /NFL /NDL /NJH /NJS /nc /ns /np
del c:\Windows\Temp\vazio.txt

REM ******************** ARQUIVOS DE LOG DO WINDOWS ********************
del C:\Windows\Logs\cbs\*.log
del C:\Windows\setupact.log
attrib -s c:\windows\logs\measuredboot\*.*
del c:\windows\logs\measuredboot\*.log
attrib -h -s C:\Windows\ServiceProfiles\NetworkService\
attrib -h -s C:\Windows\ServiceProfiles\LocalService\
del C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\MpCmdRun.log
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp\MpCmdRun.log
attrib +h +s C:\Windows\ServiceProfiles\NetworkService\
attrib +h +s C:\Windows\ServiceProfiles\LocalService\
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\*.log /s /q
del C:\Windows\Logs\MeasuredBoot\*.log 
del C:\Windows\Logs\MoSetup\*.log
del C:\Windows\Panther\*.log /s /q
del C:\Windows\Performance\WinSAT\winsat.log /s /q
del C:\Windows\inf\*.log /s /q
del C:\Windows\logs\*.log /s /q
del C:\Windows\SoftwareDistribution\*.log /s /q
del C:\Windows\Microsoft.NET\*.log /s /q

REM ******************** ARQUIVOS DE LOG DO ONEDRIVE ********************
taskkill /F /IM "OneDrive.exe"
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\setup\logs\*.log /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.odl /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.aodl /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.otc /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\OneDrive\*.qmlc /s /q

REM ******************** NAVEGADORES (Chrome, Edge, Firefox, Brave, Vivaldi) ********************
taskkill /F /IM "msedge.exe"
taskkill /F /IM "chrome.exe"
taskkill /F /IM "firefox.exe"
taskkill /F /IM "brave.exe"
taskkill /F /IM "vivaldi.exe"

REM Limpeza genérica para todos os navegadores
for /d %%F in (C:\Users\*) do (
    del %%F\AppData\Local\Microsoft\Edge\User Data\*\Cache\*.* /s /q
    del %%F\AppData\Local\Google\Chrome\User Data\*\Cache\*.* /s /q
    del %%F\AppData\Local\BraveSoftware\Brave-Browser\User Data\*\Cache\*.* /s /q
    del %%F\AppData\Local\Vivaldi\User Data\*\Cache\*.* /s /q
    del %%F\AppData\Local\Mozilla\Firefox\Profiles\*.default-release\cache2\entries\*.* /s /q
)

REM ******************** SPOTIFY ********************
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Data\*.file /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Browser\Cache\"Cache_Data"\f*. /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Browser\GPUCache\*. /s /q

REM ******************** ADOBE MEDIA CACHE FILES ********************
for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\Common\"Media Cache files"\*.* /s /q
for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\*.log /s /q

REM ******************** VMWARE ********************
del C:\ProgramData\VMware\logs\*.log /s /q

REM ******************** TeamViewer ********************
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\TeamViewer\EdgeBrowserControl\Persistent\data_*.  /s /q)
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_0 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_1 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_2 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_3 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_4 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /S /M *_5 /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /M "f_*." /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /M "data.*" /C "cmd /c del @path"))
for /d %%u in (C:\Users\*) do (if exist "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" (forfiles /P "%%u\AppData\Local\TeamViewer\EdgeBrowserControl" /M "index.*" /C "cmd /c del @path"))

goto :eof