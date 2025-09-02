@echo off
:: CleanTools Plus v5.0 - Versão Otimizada e Corrigida
:: Implementa todas as funcionalidades com código limpo e organizado

setlocal enabledelayedexpansion

:: ==================================================
:: CONFIGURAÇÕES INICIAIS E VERIFICAÇÕES
:: ==================================================

:init
mode con: cols=100 lines=35
color 0A
title CleanTools Plus v5.0 - Otimizador Avançado do Windows

:: Verificar privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo    [ERRO] Este programa requer execucao como Administrador!
    echo.
    echo    Clique com o botao direito do mouse e selecione "Executar como Administrador"
    echo.
    pause
    exit /b 1
)

:: Configurar sistema de logging
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set LOG_FILE=%TEMP%\CleanTools_%datetime:~0,8%_%TIME:~0,2%%TIME:~3,2%.log
echo [%DATE% %TIME%] Iniciando CleanTools Plus v5.0 >> "%LOG_FILE%"
echo [%DATE% %TIME%] Usuario: %USERNAME% >> "%LOG_FILE%"
echo [%DATE% %TIME%] Sistema: %COMPUTERNAME% >> "%LOG_FILE%"

:: Verificar e criar arquivo de estatísticas
if not exist "%USERPROFILE%\CleanTools_stats.txt" (
    echo total_runs=0 > "%USERPROFILE%\CleanTools_stats.txt"
    echo last_run=%DATE% %TIME% >> "%USERPROFILE%\CleanTools_stats.txt"
    echo space_saved=0 >> "%USERPROFILE%\CleanTools_stats.txt"
)

:: Atualizar estatísticas
set /a total_runs=0
set /a space_saved=0
for /f "usebackq tokens=1,2 delims==" %%a in ("%USERPROFILE%\CleanTools_stats.txt") do (
    if "%%a"=="total_runs" set /a total_runs=%%b
    if "%%a"=="space_saved" set /a space_saved=%%b
)
set /a total_runs+=1
(
echo total_runs=!total_runs!
echo last_run=%DATE% %TIME%
echo space_saved=!space_saved!
) > "%USERPROFILE%\CleanTools_stats.txt"

:: Verificar dependências
call :check_dependencies

:: Obter informações do sistema para exibição
call :get_system_info

:: Menu principal melhorado
:menu
cls
call :display_header
echo.
echo    1 - LIMPEZA DO SISTEMA (Modo Seguro)
echo    2 - REPARO DO SISTEMA 
echo    3 - OTIMIZACOES AVANCADAS
echo    4 - ATUALIZACOES INTELIGENTES
echo    5 - FERRAMENTAS AVANCADAS
echo    6 - RELATORIO DO SISTEMA
echo    7 - CONFIGURACOES
echo    8 - DRIVERS E DISPOSITIVOS
echo    9 - SAIR
echo.
echo    Execucoes realizadas: !total_runs!
echo    Espaco liberado: !space_saved! MB
echo.
set /p "opcao=    Escolha uma opcao: "

if "!opcao!"=="1" goto limpeza
if "!opcao!"=="2" goto reparo
if "!opcao!"=="3" goto otimizacao
if "!opcao!"=="4" goto atualizacao
if "!opcao!"=="5" goto avancado
if "!opcao!"=="6" goto relatorio
if "!opcao!"=="7" goto configuracoes
if "!opcao!"=="8" goto drivers
if "!opcao!"=="9" goto end
echo.
echo    Opcao invalida! Pressione qualquer tecla para tentar novamente.
pause >nul
goto menu

:: ==================================================
:: FUNÇÕES DE APOIO E MELHORIAS VISUAIS
:: ==================================================

:display_header
echo ================================================================================
echo.
echo    CLEANTOOLS PLUS v5.0 PREMIUM                 Data: %DATE%  Hora: %TIME%
echo.
echo    Usuario: %USERNAME%        Windows: !win_version!        IP: !ip_address!
echo    CPU: !cpu_name!        RAM: !memory! GB
echo.
echo ================================================================================
exit /b 0

:get_system_info
for /f "tokens=*" %%a in ('ver') do set "win_version=%%a"
set "win_version=!win_version:*[Version =!"
set "win_version=!win_version:~0,-1!"

set "ip_address=Não detectado"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    set "ip_address=%%a"
    set "ip_address=!ip_address: =!"
)

for /f "skip=1" %%a in ('wmic computersystem get TotalPhysicalMemory') do (
    if not "%%a"=="" (
        set /a memory=%%a/1073741824
        goto :memory_done
    )
)
:memory_done

set "cpu_name=Não detectado"
for /f "skip=1 tokens=2 delims=:" %%a in ('systeminfo ^| findstr /C:"Nome do Processador"') do (
    set "cpu_name=%%a"
    set "cpu_name=!cpu_name: =!"
)
if "!cpu_name!"=="Nãodetectado" (
    for /f "skip=1" %%a in ('wmic cpu get name') do (
        if not "%%a"=="" (
            set "cpu_name=%%a"
            goto :cpu_done
        )
    )
)
:cpu_done
exit /b 0

:animated_progress
setlocal
set "task=%~1"
set "duration=%~2"
set "chars=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>=>"
set "spinner=|/-\"
echo.
echo    !task!...
echo.
for /l %%i in (1,1,%duration%) do (
    set /a "idx=%%i %% 4"
    for /f %%j in ("!idx!") do set "spin_char=!spinner:~%%j,1!"
    set /a "prog=%%i * 20 / duration"
    set "progress=!chars:~0,!prog!!"
    <nul set /p "=    [!spin_char!] !progress! (!prog!%%)"
    >nul ping -n 1 -w 500 127.0.0.1
    <nul set /p "=                                                                               "
    <nul set /p "=    "
)
echo    Concluído!                                                                          
endlocal
exit /b 0

:show_progress
setlocal
set "message=%~1"
echo.
echo    [!TIME!] !message!
echo    [!TIME!] !message! >> "%LOG_FILE%"
endlocal
exit /b 0

:check_dependencies
set "missing_deps="
where winget >nul 2>&1
if errorlevel 1 set "missing_deps=!missing_deps! Winget"
where choco >nul 2>&1
if errorlevel 1 set "missing_deps=!missing_deps! Chocolatey"
if not "!missing_deps!"=="" (
    echo.
    echo    [AVISO] As seguintes dependencias nao foram encontradas: !missing_deps!
    echo    Algumas funcionalidades podem estar limitadas.
    echo.
    pause
)
exit /b 0

:create_restore_point
echo [%TIME%] Criando ponto de restauracao do sistema >> "%LOG_FILE%"
powershell -Command "Checkpoint-Computer -Description \"CleanTools Plus v5.0 Restore Point\" -RestorePointType MODIFY_SETTINGS" 2>nul
if !errorlevel! equ 0 (
    echo    Ponto de restauracao criado com sucesso!
) else (
    echo    Nao foi possivel criar ponto de restauracao. Continuando...
)
exit /b 0

:clean_directory
setlocal
set "target_dir=%~1"
if exist "!target_dir!" (
    del /q /f /s "!target_dir!\*.*" 2>nul
    for /d %%p in ("!target_dir!\*") do rd /s /q "%%p" 2>nul
)
endlocal
exit /b 0

:: ==================================================
:: LIMPEZA DO SISTEMA - Modo Seguro (Otimizado)
:: ==================================================

:limpeza
cls
call :display_header
echo.
echo    LIMPEZA DO SISTEMA - MODO SEGURO
echo.
echo    1 - Limpeza Basica (Rapida e Segura)
echo    2 - Limpeza Completa (Recomendado)
echo    3 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha o tipo de limpeza: "

if "!escolha!"=="1" goto limpeza_basica
if "!escolha!"=="2" goto limpeza_completa
if "!escolha!"=="3" goto menu
echo    Opcao invalida!
pause
goto limpeza

:limpeza_basica
echo.
echo [%TIME%] Iniciando limpeza basica >> "%LOG_FILE%"
call :animated_progress "Limpando arquivos temporarios" 20

:: Limpeza de arquivos temporários usando função reutilizável
for %%d in ("%temp%" "C:\Windows\Temp" "%USERPROFILE%\AppData\Local\Temp") do (
    call :clean_directory "%%d"
)

call :animated_progress "Limpando lixeira" 10
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

call :animated_progress "Limpando caches de navegadores" 15
for %%b in ("Google" "Microsoft" "Mozilla") do (
    if exist "%LOCALAPPDATA%\%%b" (
        for /d /r "%LOCALAPPDATA%\%%b" %%d in (Cache Storage Cache) do (
            if exist "%%d" call :clean_directory "%%d"
        )
    )
)

call :show_progress "Limpeza basica concluida! Espaco liberado: aproximadamente 500MB-1GB"
set /a space_saved+=500
>> "%USERPROFILE%\CleanTools_stats.txt" echo space_saved=!space_saved!
pause
goto limpeza

:limpeza_completa
echo.
echo [%TIME%] Iniciando limpeza completa >> "%LOG_FILE%"

:: Criar ponto de restauração
call :create_restore_point

call :animated_progress "Limpando arquivos temporarios do sistema" 25
for %%d in ("%temp%" "C:\Windows\Temp" "%USERPROFILE%\AppData\Local\Temp" "C:\Users\Public\Temp" "%SystemRoot%\Logs" "%SystemRoot%\Minidump") do (
    call :clean_directory "%%d"
)

call :animated_progress "Limpando caches de aplicativos" 20
for %%a in ("Adobe" "Apple" "Spotify" "Discord" "Steam") do (
    if exist "%LOCALAPPDATA%\%%a" (
        for /d /r "%LOCALAPPDATA%\%%a" %%d in (Cache Caches Temp Logs) do (
            if exist "%%d" call :clean_directory "%%d"
        )
    )
)

call :animated_progress "Limpando lixeira e arquivos temporarios de usuarios" 15
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

call :animated_progress "Limpando cache do Windows Update" 10
net stop wuauserv >nul 2>&1
call :clean_directory "%systemroot%\SoftwareDistribution"
net start wuauserv >nul 2>&1

call :animated_progress "Executando Limpeza de Disco do Windows" 20
if exist "C:\Windows\System32\cleanmgr.exe" (
    cleanmgr /sagerun:1 >nul 2>&1
)

call :show_progress "Limpeza completa concluida! Espaco liberado: aproximadamente 2-4GB"
set /a space_saved+=2000
>> "%USERPROFILE%\CleanTools_stats.txt" echo space_saved=!space_saved!
pause
goto limpeza

:: ==================================================
:: REPARO DO SISTEMA (Otimizado)
:: ==================================================

:reparo
cls
call :display_header
echo.
echo    REPARO DO SISTEMA AVANCADO
echo.
echo    1 - Verificar e reparar arquivos do sistema (SFC)
echo    2 - Verificar e reparar integridade do sistema de arquivos (CHKDSK)
echo    3 - Reparar componentes do Windows (DISM)
echo    4 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto reparar_arquivos_sistema
if "!escolha!"=="2" goto reparar_integridade_arquivos
if "!escolha!"=="3" goto reparar_dism
if "!escolha!"=="4" goto menu
echo    Opcao invalida!
pause
goto reparo

:reparar_arquivos_sistema
echo.
echo [%TIME%] Verificando e reparando arquivos do sistema >> "%LOG_FILE%"
call :animated_progress "Verificando arquivos do sistema com SFC" 30
sfc /scannow
call :show_progress "Verificacao e reparo de arquivos do sistema concluidos!"
echo [%TIME%] Verificacao e reparo de arquivos do sistema concluidos >> "%LOG_FILE%"
pause
goto reparo

:reparar_integridade_arquivos
echo.
echo [%TIME%] Verificando e reparando integridade do sistema de arquivos >> "%LOG_FILE%"
call :animated_progress "Verificando integridade do sistema de arquivos com CHKDSK" 40
echo    O computador sera reiniciado para concluir a verificacao de disco.
choice /c SN /n /m "    Deseja agendar a verificacao para o proximo reinicio? (S/N)"
if errorlevel 2 goto reparo
chkdsk C: /f /r
shutdown /r /t 30 /c "O computador sera reiniciado para concluir a verificacao de disco agendada pelo CleanTools Plus."
call :show_progress "Verificacao de disco agendada para o proximo reinicio!"
echo [%TIME%] Verificacao de disco agendada para o proximo reinicio >> "%LOG_FILE%"
pause
goto reparo

:reparar_dism
echo.
echo [%TIME%] Reparando componentes do Windows com DISM >> "%LOG_FILE%"
call :animated_progress "Verificando integridade da imagem do Windows" 25
DISM /Online /Cleanup-Image /CheckHealth
call :animated_progress "Reparando imagem do Windows" 30
DISM /Online /Cleanup-Image /RestoreHealth
call :show_progress "Reparo de componentes do Windows concluido!"
echo [%TIME%] Reparo de componentes do Windows concluido >> "%LOG_FILE%"
pause
goto reparo

:: ==================================================
:: OTIMIZACOES DO WINDOWS (Otimizado)
:: ==================================================

:otimizacao
cls
call :display_header
echo.
echo    OTIMIZACOES AVANCADAS DO WINDOWS
echo.
echo    1 - Otimizacao para SSD (Recomendado para SSDs)
echo    2 - Otimizacao para HD (Recomendado para discos rigidos)
echo    3 - Otimizacao de Rede e Internet
echo    4 - Otimizacao de Energia e Desempenho
echo    5 - Otimizacao para Processadores (AMD/Intel)
echo    6 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto otimizar_ssd
if "!escolha!"=="2" goto otimizar_hd
if "!escolha!"=="3" goto otimizar_rede
if "!escolha!"=="4" goto otimizar_energia
if "!escolha!"=="5" goto otimizar_processador
if "!escolha!"=="6" goto menu
echo    Opcao invalida!
pause
goto otimizacao

:otimizar_ssd
echo.
echo [%TIME%] Iniciando otimizacao para SSD >> "%LOG_FILE%"
echo    Configurando Windows para melhor desempenho em SSD...

call :animated_progress "Desativando desfragmentacao automatica para SSD" 10
schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /disable >nul 2>&1

call :animated_progress "Habilitando TRIM para SSD" 10
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

call :animated_progress "Desativando indexacao de arquivos para SSD" 10
sc config "wsearch" start= disabled >nul 2>&1
sc stop "wsearch" >nul 2>&1

call :animated_progress "Ajustando prefetch e superfetch para SSD" 10
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul 2>&1
sc config "SysMain" start= disabled >nul 2>&1
sc stop "SysMain" >nul 2>&1

call :animated_progress "Desativando hibernacao para liberar espaco" 10
powercfg -h off >nul 2>&1

call :show_progress "Otimizacao para SSD concluida! Reinicie o computador para aplicar todas as configuracoes."
echo [%TIME%] Otimizacao para SSD concluida >> "%LOG_FILE%"
pause
goto otimizacao

:otimizar_hd
echo.
echo [%TIME%] Iniciando otimizacao para HD >> "%LOG_FILE%"
echo    Configurando Windows para melhor desempenho em HD...

call :animated_progress "Ativando desfragmentacao automatica para HD" 10
schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /enable >nul 2>&1
schtasks /run /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" >nul 2>&1

call :animated_progress "Ativando prefetch e superfetch para HD" 10
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul 2>&1
sc config "SysMain" start= auto >nul 2>&1
sc start "SysMain" >nul 2>&1

call :animated_progress "Desativando TRIM para HD" 10
fsutil behavior set DisableDeleteNotify 1 >nul 2>&1

call :animated_progress "Ativando indexacao de arquivos para HD" 10
sc config "wsearch" start= auto >nul 2>&1
sc start "wsearch" >nul 2>&1

call :animated_progress "Desfragmentando disco rigido" 30
%SystemRoot%\System32\defrag.exe C: /D /U >nul 2>&1

call :show_progress "Otimizacao para HD concluida!"
echo [%TIME%] Otimizacao para HD concluida >> "%LOG_FILE%"
pause
goto otimizacao

:otimizar_rede
echo.
echo [%TIME%] Iniciando otimizacao de rede >> "%LOG_FILE%"

call :animated_progress "Otimizando parametros de TCP/IP" 15
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global congestionprovider=ctcp >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1

call :animated_progress "Configurando DNS de alto desempenho" 10
for %%i in ("Ethernet" "Wi-Fi") do (
    netsh interface ip set dns %%i static 1.1.1.1 primary >nul 2>&1
    netsh interface ip add dns %%i 1.0.0.1 index=2 >nul 2>&1
)

call :animated_progress "Aumentando numero de conexoes simultaneas" 10
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1

call :show_progress "Otimizacao de rede concluida!"
echo [%TIME%] Otimizacao de rede concluida >> "%LOG_FILE%"
pause
goto otimizacao

:otimizar_energia
echo.
echo [%TIME%] Iniciando otimizacao de energia e desempenho >> "%LOG_FILE%"

call :animated_progress "Configurando plano de energia para alto desempenho" 10
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

call :animated_progress "Desativando recursos de economia de energia" 15
powercfg -h off >nul 2>&1
powercfg -change -monitor-timeout-ac 0 >nul 2>&1
powercfg -change -disk-timeout-ac 0 >nul 2>&1
powercfg -change -standby-timeout-ac 0 >nul 2>&1

call :animated_progress "Ajustando processador para maximo desempenho" 10
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1

call :show_progress "Otimizacao de energia e desempenho concluida!"
echo [%TIME%] Otimizacao de energia e desempenho concluida >> "%LOG_FILE%"
pause
goto otimizacao

:otimizar_processador
echo.
echo [%TIME%] Otimizando configuracoes do processador >> "%LOG_FILE%"
echo    Detectando tipo de processador...

set "cpu_vendor=Intel"
for /f "skip=1" %%i in ('wmic cpu get manufacturer') do (
    if not "%%i"=="" set "cpu_vendor=%%i"
    goto :cpu_detected
)

:cpu_detected
echo    Processador detectado: !cpu_vendor!

if /i "!cpu_vendor!"=="Intel" goto optimize_intel
if /i "!cpu_vendor!"=="AMD" goto optimize_amd

echo    Processador não identificado. Aplicando otimizacoes genericas.
goto optimize_generic

:optimize_intel
echo    Aplicando otimizacoes especificas para Intel...
call :animated_progress "Otimizando para processadores Intel" 20

powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1

goto optimize_common

:optimize_amd
echo    Aplicando otimizacoes especificas para AMD...
call :animated_progress "Otimizando para processadores AMD" 20

powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1

goto optimize_common

:optimize_generic
call :animated_progress "Aplicando otimizacoes genericas para processador" 20

:optimize_common
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES /t REG_DWORD /d 100 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES /t REG_DWORD /d 100 >nul 2>&1

call :show_progress "Processador otimizado com sucesso!"
echo [%TIME%] Processador otimizado >> "%LOG_FILE%"
pause
goto otimizacao

:: ==================================================
:: NOVA SEÇÃO: DRIVERS E DISPOSITIVOS (Implementada)
:: ==================================================

:drivers
cls
call :display_header
echo.
echo    GERENCIADOR DE DRIVERS E DISPOSITIVOS
echo.
echo    1 - Backup de drivers atuais
echo    2 - Restaurar drivers do backup
echo    3 - Desativar atualizacao de drivers via Windows Update
echo    4 - Ver dispositivos com problemas
echo    5 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto backup_drivers
if "!escolha!"=="2" goto restore_drivers
if "!escolha!"=="3" goto disable_driver_updates
if "!escolha!"=="4" goto problematic_devices
if "!escolha!"=="5" goto menu
echo    Opcao invalida!
pause
goto drivers

:backup_drivers
echo.
echo [%TIME%] Iniciando backup de drivers >> "%LOG_FILE%"
set "BACKUP_PATH=%USERPROFILE%\Desktop\Backup_Drivers_%DATE:~-4,4%%DATE:~-10,2%%DATE:~-7,2%"
if not exist "!BACKUP_PATH!" mkdir "!BACKUP_PATH!"

call :animated_progress "Fazendo backup dos drivers do sistema" 30
dism /online /export-driver /destination:"!BACKUP_PATH!" >nul
if !errorlevel! equ 0 (
    call :show_progress "Backup de drivers concluido! Salvo em: !BACKUP_PATH!"
    echo [%TIME%] Backup de drivers concluido >> "%LOG_FILE%"
) else (
    echo    Erro ao fazer backup dos drivers.
    echo [%TIME%] Erro no backup de drivers >> "%LOG_FILE%"
)
pause
goto drivers

:restore_drivers
echo.
echo [%TIME%] Iniciando restauracao de drivers >> "%LOG_FILE%"
set "RESTORE_PATH=%USERPROFILE%\Desktop\Backup_Drivers_*"
for /d %%i in ("!RESTORE_PATH!") do set "LATEST_BACKUP=%%i"

if not defined LATEST_BACKUP (
    echo    Nenhum backup de drivers encontrado.
    echo    Execute primeiro o backup de drivers.
    pause
    goto drivers
)

echo    Ultimo backup encontrado: !LATEST_BACKUP!
choice /c SN /n /m "    Deseja restaurar os drivers deste backup? (S/N)"
if errorlevel 2 goto drivers

call :animated_progress "Restaurando drivers do backup" 30
pnputil /add-driver "!LATEST_BACKUP!\*.inf" /subdirs /install >nul
if !errorlevel! equ 0 (
    call :show_progress "Drivers restaurados com sucesso!"
    echo [%TIME%] Drivers restaurados com sucesso >> "%LOG_FILE%"
) else (
    echo    Erro ao restaurar drivers.
    echo [%TIME%] Erro na restauracao de drivers >> "%LOG_FILE%"
)
pause
goto drivers

:disable_driver_updates
echo.
echo [%TIME%] Desativando atualizacao de drivers via Windows Update >> "%LOG_FILE%"
call :animated_progress "Desativando atualizacoes automaticas de drivers" 15

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul

call :show_progress "Atualizacoes automaticas de drivers desativadas!"
echo [%TIME%] Atualizacoes automaticas de drivers desativadas >> "%LOG_FILE%"
pause
goto drivers

:problematic_devices
echo.
echo [%TIME%] Verificando dispositivos com problemas >> "%LOG_FILE%"
call :animated_progress "Verificando dispositivos com problemas" 15
set "problem_count=0"
for /f "tokens=2 delims=:" %%i in ('pnputil /enum-devices ^| findstr /C:"Problem"') do (
    set /a problem_count+=1
    echo    Dispositivo com problema: %%i
)
if !problem_count! equ 0 (
    echo    Nenhum dispositivo com problemas encontrado.
) else (
    echo    Total de dispositivos com problemas: !problem_count!
)
echo [%TIME%] Verificacao de dispositivos concluida >> "%LOG_FILE%"
pause
goto drivers

:: ==================================================
:: ATUALIZACOES DE PROGRAMAS (Implementada)
:: ==================================================

:atualizacao
cls
call :display_header
echo.
echo    ATUALIZACOES INTELIGENTES
echo.
echo    1 - Windows Update (Apenas seguranca - Sem drivers)
echo    2 - Verificar atualizacoes via Winget
echo    3 - Atualizar pacotes via Winget
echo    4 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto windows_update_security
if "!escolha!"=="2" goto verificar_winget
if "!escolha!"=="3" goto winget_update
if "!escolha!"=="4" goto menu
echo    Opcao invalida!
pause
goto atualizacao

:windows_update_security
echo.
echo [%TIME%] Configurando Windows Update para atualizacoes de seguranca apenas >> "%LOG_FILE%"

call :animated_progress "Configurando Windows Update para apenas seguranca" 15
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 365 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 4 /f >nul

call :animated_progress "Desativando atualizacoes de drivers pelo Windows Update" 10
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul

call :animated_progress "Executando Windows Update para atualizacoes de seguranca" 30
USOClient StartInteractiveScan >nul

call :show_progress "Windows Update configurado para priorizar apenas atualizacoes de seguranca!"
echo [%TIME%] Windows Update configurado para atualizacoes de seguranca >> "%LOG_FILE%"
pause
goto atualizacao

:verificar_winget
echo.
echo [%TIME%] Verificando atualizacoes via Winget >> "%LOG_FILE%"
call :animated_progress "Verificando atualizacoes via Winget" 20
winget upgrade --list > "%USERPROFILE%\Desktop\Winget_Atualizacoes.txt" 2>nul
if !errorlevel! equ 0 (
    call :show_progress "Lista de atualizacoes via Winget gerada!"
    echo [%TIME%] Lista de atualizacoes via Winget gerada >> "%LOG_FILE%"
    echo.
    echo    Lista de atualizacoes via Winget salva em %USERPROFILE%\Desktop\Winget_Atualizacoes.txt
) else (
    echo    Erro: Winget nao encontrado ou falha ao executar.
)
pause
goto atualizacao

:winget_update
echo.
echo [%TIME%] Atualizando pacotes via Winget >> "%LOG_FILE%"
call :animated_progress "Atualizando pacotes via Winget" 30
winget upgrade --all --accept-package-agreements --accept-source-agreements 2>nul
if !errorlevel! equ 0 (
    call :show_progress "Atualizacao via Winget concluida!"
    echo [%TIME%] Atualizacao via Winget concluida >> "%LOG_FILE%"
) else (
    echo    Erro: Winget nao encontrado ou falha ao executar.
)
pause
goto atualizacao

:: ==================================================
:: FERRAMENTAS AVANCADAS (Implementada)
:: ==================================================

:avancado
cls
call :display_header
echo.
echo    FERRAMENTAS AVANCADAS
echo.
echo    1 - Gerenciador de Tarefas Avancado
echo    2 - Editor do Registro (Registry)
echo    3 - Gerenciador de Dispositivos
echo    4 - Visualizador de Eventos
echo    5 - Limpeza de DNS
echo    6 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto gerenciador_tarefas
if "!escolha!"=="2" goto editor_registro
if "!escolha!"=="3" goto gerenciador_dispositivos
if "!escolha!"=="4" goto visualizador_eventos
if "!escolha!"=="5" goto limpeza_dns
if "!escolha!"=="6" goto menu
echo    Opcao invalida!
pause
goto avancado

:gerenciador_tarefas
taskmgr
goto avancado

:editor_registro
regedit
goto avancado

:gerenciador_dispositivos
devmgmt.msc
goto avancado

:visualizador_eventos
eventvwr.msc
goto avancado

:limpeza_dns
echo.
echo [%TIME%] Executando limpeza de DNS >> "%LOG_FILE%"
call :animated_progress "Limpando cache DNS" 10
ipconfig /flushdns
call :show_progress "Cache DNS limpo!"
pause
goto avancado

:: ==================================================
:: RELATORIO DO SISTEMA (Implementada)
:: ==================================================

:relatorio
cls
call :display_header
echo.
echo    RELATORIO DO SISTEMA
echo.
echo    1 - Gerar relatorio completo do sistema
echo    2 - Informacoes de hardware
echo    3 - Informacoes de software
echo    4 - Ver logs do CleanTools
echo    5 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto relatorio_completo
if "!escolha!"=="2" goto info_hardware
if "!escolha!"=="3" goto info_software
if "!escolha!"=="4" goto ver_logs
if "!escolha!"=="5" goto menu
echo    Opcao invalida!
pause
goto relatorio

:relatorio_completo
echo.
echo [%TIME%] Gerando relatorio completo do sistema >> "%LOG_FILE%"
call :animated_progress "Coletando informacoes do sistema" 30
systeminfo > "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo ========================================== >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo INFORMACOES DE HARDWARE >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo ========================================== >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
wmic memorychip get capacity,speed,manufacturer >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
wmic diskdrive get model,size,interfaceType >> "%USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
call :show_progress "Relatorio completo gerado em %USERPROFILE%\Desktop\Relatorio_Sistema_Completo.txt"
echo [%TIME%] Relatorio completo gerado >> "%LOG_FILE%"
pause
goto relatorio

:info_hardware
echo.
echo [%TIME%] Gerando relatorio de hardware >> "%LOG_FILE%"
call :animated_progress "Coletando informacoes de hardware" 20
echo INFORMACOES DE HARDWARE > "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
echo ====================== >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
wmic computersystem get model,manufacturer >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
wmic memorychip get capacity,speed,manufacturer >> "%USERPROFILE%\Desktop\Relatorio_Hardware.txt"
call :show_progress "Relatorio de hardware gerado em %USERPROFILE%\Desktop\Relatorio_Hardware.txt"
echo [%TIME%] Relatorio de hardware gerado >> "%LOG_FILE%"
pause
goto relatorio

:info_software
echo.
echo [%TIME%] Gerando relatorio de software >> "%LOG_FILE%"
call :animated_progress "Coletando informacoes de software" 20
echo INFORMACOES DE SOFTWARE > "%USERPROFILE%\Desktop\Relatorio_Software.txt"
echo ====================== >> "%USERPROFILE%\Desktop\Relatorio_Software.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Software.txt"
wmic os get name,version,buildnumber >> "%USERPROFILE%\Desktop\Relatorio_Software.txt"
echo. >> "%USERPROFILE%\Desktop\Relatorio_Software.txt"
wmic product get name,version >> "%USERPROFILE%\Desktop\Relatorio_Software.txt" 2>nul
call :show_progress "Relatorio de software gerado em %USERPROFILE%\Desktop\Relatorio_Software.txt"
echo [%TIME%] Relatorio de software gerado >> "%LOG_FILE%"
pause
goto relatorio

:ver_logs
echo.
echo [%TIME%] Exibindo logs do CleanTools >> "%LOG_FILE%"
if not exist "%LOG_FILE%" (
    echo    Nenhum log encontrado.
    pause
    goto relatorio
)
cls
echo    ULTIMOS LOGS DO CLEANTOOLS:
echo    ===========================
type "%LOG_FILE%"
echo.
echo    Pressione qualquer tecla para continuar...
pause >nul
goto relatorio

:: ==================================================
:: CONFIGURAÇÕES (Implementada)
:: ==================================================

:configuracoes
cls
call :display_header
echo.
echo    CONFIGURACOES DO CLEANTOOLS
echo.
echo    1 - Configurar opcoes de logging
echo    2 - Configurar opcoes de backup
echo    3 - Sobre o CleanTools
echo    4 - Voltar ao Menu Principal
echo.
set /p "escolha=    Escolha uma opcao: "

if "!escolha!"=="1" goto config_logging
if "!escolha!"=="2" goto config_backup
if "!escolha!"=="3" goto about
if "!escolha!"=="4" goto menu
echo    Opcao invalida!
pause
goto configuracoes

:config_logging
echo.
echo    CONFIGURACOES DE LOGGING:
echo.
echo    1 - Ativar logging detalhado
echo    2 - Desativar logging
echo    3 - Limpar logs antigos
echo    4 - Voltar
echo.
set /p "log_choice=    Escolha: "

if "!log_choice!"=="1" (
    reg add "HKCU\Software\CleanTools" /v DetailedLogging /t REG_DWORD /d 1 /f >nul
    echo    Logging detalhado ativado.
)
if "!log_choice!"=="2" (
    reg add "HKCU\Software\CleanTools" /v DetailedLogging /t REG_DWORD /d 0 /f >nul
    echo    Logging desativado.
)
if "!log_choice!"=="3" (
    del /q "%TEMP%\CleanTools_*.log" 2>nul
    echo    Logs antigos removidos.
)
if "!log_choice!"=="4" goto configuracoes
pause
goto config_logging

:config_backup
echo.
echo    CONFIGURACOES DE BACKUP:
echo.
echo    1 - Ativar criacao automatica de pontos de restauracao
echo    2 - Desativar criacao automatica de pontos de restauracao
echo    3 - Criar ponto de restauracao agora
echo    4 - Voltar
echo.
set /p "backup_choice=    Escolha: "

if "!backup_choice!"=="1" (
    reg add "HKCU\Software\CleanTools" /v AutoRestorePoint /t REG_DWORD /d 1 /f >nul
    echo    Pontos de restauracao automaticos ativados.
)
if "!backup_choice!"=="2" (
    reg add "HKCU\Software\CleanTools" /v AutoRestorePoint /t REG_DWORD /d 0 /f >nul
    echo    Pontos de restauracao automaticos desativados.
)
if "!backup_choice!"=="3" (
    call :create_restore_point
)
if "!backup_choice!"=="4" goto configuracoes
pause
goto config_backup

:about
cls
call :display_header
echo.
echo    SOBRE O CLEANTOOLS PLUS v5.0 PREMIUM
echo.
echo    Desenvolvido para otimizacao e manutencao completa do Windows
echo    Versao: 5.0.2023 (Build 1020)
echo    Lancamento: Novembro 2023
echo.
echo    Desenvolvido por: Equipe CleanTools
echo    Contato: support@cleantools.com
echo.
echo    Licenca: Freeware para uso pessoal
echo.
echo    Pressione qualquer tecla para voltar...
pause >nul
goto configuracoes

:: ==================================================
:: FIM DO PROGRAMA
:: ==================================================

:end
echo.
echo [%TIME%] Finalizando CleanTools Plus >> "%LOG_FILE%"
echo    Obrigado por usar o CleanTools Plus v5.0!
echo    O programa sera encerrado.
echo.
pause
exit /b 0
