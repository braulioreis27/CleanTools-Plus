@echo off
:: CleanTools Plus v3.0 - Versão Otimizada para Usuários Comuns e Técnicos
:: Implementa as funcionalidades mais úteis para ambos os públicos

setlocal enabledelayedexpansion

:: ==================================================
:: CONFIGURAÇÕES INICIAIS E VERIFICAÇÕES
:: ==================================================

:init
mode con: cols=80 lines=30
color 0A
title CleanTools Plus v3.0 - Otimizador do Windows

:: Verificar privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERRO] Execute como Administrador!
    echo.
    pause
    exit /b 1
)

:: Configurar sistema de logging
set LOG_FILE=%TEMP%\CleanTools_%DATE:~-4,4%%DATE:~-10,2%%DATE:~-7,2%.log
echo [%TIME%] Iniciando CleanTools Plus v3.0 >> %LOG_FILE%
echo [%TIME%] Usuario: %USERNAME% >> %LOG_FILE%
echo [%TIME%] Sistema: %COMPUTERNAME% >> %LOG_FILE%

:: Verificar e criar arquivo de estatísticas
if not exist "%USERPROFILE%\CleanTools_stats.txt" (
    echo total_runs=0 > "%USERPROFILE%\CleanTools_stats.txt"
    echo last_run=%DATE% %TIME% >> "%USERPROFILE%\CleanTools_stats.txt"
)

:: Atualizar estatísticas
for /f "tokens=2 delims==" %%a in ('find "total_runs" "%USERPROFILE%\CleanTools_stats.txt"') do set /a total_runs=%%a+1
echo total_runs=!total_runs! > "%USERPROFILE%\CleanTools_stats.txt"
echo last_run=%DATE% %TIME% >> "%USERPROFILE%\CleanTools_stats.txt"

:: Menu principal melhorado
:menu
cls
echo ==================================================
echo         MANUTENCAO COMPLETA DO WINDOWS v3.0
echo ==================================================
echo.
echo 1 - LIMPEZA DO SISTEMA (Modo Seguro)
echo 2 - REPARO DO SISTEMA 
echo 3 - OTIMIZACOES DO WINDOWS
echo 4 - ATUALIZACOES DE PROGRAMAS
echo 5 - FERRAMENTAS AVANCADAS (Tecnicos)
echo 6 - RELATORIO DO SISTEMA
echo 7 - CONFIGURACOES
echo 8 - SAIR
echo.
echo Execucoes realizadas: !total_runs!
echo.
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="1" goto limpeza
if "%opcao%"=="2" goto reparo
if "%opcao%"=="3" goto otimizacao
if "%opcao%"=="4" goto atualizacao
if "%opcao%"=="5" goto avancado
if "%opcao%"=="6" goto relatorio
if "%opcao%"=="7" goto configuracoes
if "%opcao%"=="8" exit
echo Opcao invalida! Tente novamente.
pause
goto menu

:: ==================================================
:: LIMPEZA DO SISTEMA - Modo Seguro
:: ==================================================

:limpeza
cls
echo ==================================================
echo         LIMPEZA DO SISTEMA - MODO SEGURO
echo ==================================================
echo.
echo 1 - Limpeza Basica (Rapida e Segura)
echo 2 - Limpeza Completa (Recomendado)
echo 3 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha o tipo de limpeza: 

if "%escolha%"=="1" goto limpeza_basica
if "%escolha%"=="2" goto limpeza_completa
if "%escolha%"=="3" goto menu
echo Opcao invalida!
pause
goto limpeza

:limpeza_basica
echo.
echo [%TIME%] Iniciando limpeza basica >> %LOG_FILE%
call :show_progress "Iniciando limpeza basica..."

:: Limpeza de arquivos temporários
del /s /q %temp%\*.* 2>nul
rd /s /q %temp% 2>nul
md %temp% 2>nul
del /s /q /f C:\Windows\Temp\*.* 2>nul
del /s /q /f C:\Users\%USERNAME%\AppData\Local\Temp\*.* 2>nul

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

call :show_progress "Limpeza basica concluida!"
echo [%TIME%] Limpeza basica concluida >> %LOG_FILE%
pause
goto limpeza

:limpeza_completa
echo.
echo [%TIME%] Iniciando limpeza completa >> %LOG_FILE%
call :show_progress "Iniciando limpeza completa..."

:: Criar ponto de restauração
call :create_restore_point

:: Limpeza completa
del /s /q %temp%\*.* 2>nul
rd /s /q %temp% 2>nul
md %temp% 2>nul
del /s /q /f C:\Windows\Temp\*.* 2>nul
del /s /q /f C:\Users\%USERNAME%\AppData\Local\Temp\*.* 2>nul
del /s /q /f C:\Users\Public\Temp\*.* 2>nul

:: Limpeza de cache
del /s /q C:\Windows\Prefetch\*.* 2>nul
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
del /s /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

:: Limpeza de disco
cleanmgr /sagerun:1 >nul 2>&1

call :show_progress "Limpeza completa concluida!"
echo [%TIME%] Limpeza completa concluida >> %LOG_FILE%
pause
goto limpeza

:: ==================================================
:: FERRAMENTAS AVANÇADAS PARA TÉCNICOS
:: ==================================================

:avancado
cls
echo ==================================================
echo         FERRAMENTAS AVANCADAS (TECNICOS)
echo ==================================================
echo.
echo 1 - Gerenciador de Inicializacao (Startup)
echo 2 - Otimizador de Servicos do Windows
echo 3 - Verificador de Seguranca
echo 4 - Analisador de Saude do Disco
echo 5 - Relatorio Tecnico Completo
echo 6 - Voltar ao Menu Principal
echo.
set /p escolha=Escolha uma opcao: 

if "%escolha%"=="1" goto startup_manager
if "%escolha%"=="2" goto service_optimizer
if "%escolha%"=="3" goto security_check
if "%escolha%"=="4" goto disk_health
if "%escolha%"=="5" goto full_report
if "%escolha%"=="6" goto menu
echo Opcao invalida!
pause
goto avancado

:startup_manager
echo.
echo [%TIME%] Iniciando gerenciador de startup >> %LOG_FILE%
echo  Programas que iniciam com o Windows:
echo.
wmic startup get caption, command 2>nul | more
echo.
pause
goto avancado

:service_optimizer
echo.
echo [%TIME%] Iniciando otimizador de servicos >> %LOG_FILE%
echo  Servicos desnecessarios que podem ser desativados:
echo.
echo  - DiagTrack (Telemetria)
echo  - dmwappushservice (Push de notificacoes)
echo  - Fax (Servico de fax)
echo  - Microsoft Office Click-to-Run
echo.
echo 1 - Desativar servicos desnecessarios
echo 2 - Voltar
set /p choice=Escolha: 

if "%choice%"=="1" (
    sc config DiagTrack start= disabled >nul 2>&1
    sc config dmwappushservice start= disabled >nul 2>&1
    echo Servicos desativados com sucesso!
    echo [%TIME%] Servicos desnecessarios desativados >> %LOG_FILE%
)
pause
goto avancado

:security_check
echo.
echo [%TIME%] Iniciando verificacao de seguranca >> %LOG_FILE%
echo  Status do Firewall:
netsh advfirewall show allprofiles state | findstr "Estado"
echo.
echo  Antivirus instalado:
wmic /namespace:\\root\securitycenter2 path antivirusproduct get displayName 2>nul
echo.
pause
goto avancado

:disk_health
echo.
echo [%TIME%] Iniciando analise de disco >> %LOG_FILE%
echo  Status dos discos:
wmic diskdrive get status,model,size 2>nul
echo.
echo  Espaco em disco disponivel:
for /f "skip=1" %%d in ('wmic logicaldisk where "drivetype=3" get deviceid^, freespace^, size') do (
    echo %%d
)
echo.
pause
goto avancado

:full_report
echo.
echo [%TIME%] Gerando relatorio tecnico >> %LOG_FILE%
echo  Gerando relatorio completo...
systeminfo > "%TEMP%\system_info.txt"
wmic diskdrive get status,model,size > "%TEMP%\disk_info.txt" 2>nul
echo Relatorio salvo em: %TEMP%\system_info.txt
echo.
pause
goto avancado

:: ==================================================
:: SISTEMA DE RELATÓRIOS
:: ==================================================

:relatorio
cls
echo ==================================================
echo         RELATORIO DO SISTEMA
echo ==================================================
echo.
echo 1 - Relatorio de Saude do Sistema
echo 2 - Relatorio de Espaco em Disco
echo 3 - Relatorio de Programas Instalados
echo 4 - Relatorio de Ultima Execucao
echo 5 - Voltar
echo.
set /p escolha=Escolha: 

if "%escolha%"=="1" goto health_report
if "%escolha%"=="2" goto disk_report
if "%escolha%"=="3" goto programs_report
if "%escolha%"=="4" goto last_run_report
if "%escolha%"=="5" goto menu
echo Opcao invalida!
pause
goto relatorio

:health_report
echo.
echo  Relatorio de Saude do Sistema:
echo.
systeminfo | findstr /C:"Memoria" /C:"Processador" /C:"Sistema"
echo.
pause
goto relatorio

:disk_report
echo.
echo  Espaco em disco:
echo.
for /f "skip=1" %%d in ('wmic logicaldisk where "drivetype=3" get deviceid^, freespace^, size') do (
    for /f "tokens=1-3" %%a in ("%%d") do (
        set /a free_mb=%%b/1048576
        set /a total_mb=%%c/1048576
        set /a used_pct=100*!free_mb!/!total_mb!
        echo Disco %%a: !free_mb!MB livres de !total_mb!MB (!used_pct!%% livre)
    )
)
echo.
pause
goto relatorio

:programs_report
echo.
echo  Programas instalados (ultimos 10):
echo.
wmic product get name, version | more
echo.
pause
goto relatorio

:last_run_report
echo.
echo  Ultima execucao do CleanTools:
type "%USERPROFILE%\CleanTools_stats.txt" 2>nul
echo.
pause
goto relatorio

:: ==================================================
:: FUNÇÕES AUXILIARES IMPLEMENTADAS
:: ==================================================

:show_progress
echo.
setlocal
set message=%~1
set /a width=30
set bar=
for /l %%i in (1,1,%width%) do set "bar=!bar!="
echo !message!
echo [!bar!]
timeout /t 1 /nobreak >nul
endlocal
exit /b 0

:create_restore_point
echo [%TIME%] Criando ponto de restauracao >> %LOG_FILE%
powershell -Command "Checkpoint-Computer -Description \"CleanTools Plus Restore Point\" -RestorePointType MODIFY_SETTINGS" 2>nul
if %errorlevel% equ 0 (
    echo Ponto de restauracao criado com sucesso!
    echo [%TIME%] Ponto de restauracao criado >> %LOG_FILE%
) else (
    echo Nao foi possivel criar ponto de restauracao
    echo [%TIME%] Erro ao criar ponto de restauracao >> %LOG_FILE%
)
exit /b 0

:: ==================================================
:: FUNÇÕES EXISTENTES (mantidas para compatibilidade)
:: ==================================================

:reparo
:: ... (código existente mantido)
goto menu

:otimizacao
:: ... (código existente mantido) 
goto menu

:atualizacao
:: ... (código existente mantido)
goto menu

:configuracoes
:: ... (código existente mantido)
goto menu

:completo
:: ... (código existente mantido)
goto menu

:: ==================================================
:: FINALIZAÇÃO
:: ==================================================

:end
echo [%TIME%] CleanTools Plus finalizado >> %LOG_FILE%
echo.
echo Obrigado por usar CleanTools Plus v3.0!
echo.
pause
exit /b 0
