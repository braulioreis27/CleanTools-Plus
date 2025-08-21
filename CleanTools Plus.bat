@echo off
:: CleanTools Plus v3.1 - Versão Corrigida e Otimizada
:: Implementa as funcionalidades mais úteis para ambos os públicos

setlocal enabledelayedexpansion

:: ==================================================
:: CONFIGURAÇÕES INICIAIS E VERIFICAÇÕES
:: ==================================================

:init
mode con: cols=80 lines=30
color 0A
title CleanTools Plus v3.1 - Otimizador do Windows

:: Verificar privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERRO] Execute como Administrador!
    echo.
    pause
    exit /b 1
)

:: Configurar sistema de logging
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set LOG_FILE=%TEMP%\CleanTools_%datetime:~0,8%.log
echo [%TIME%] Iniciando CleanTools Plus v3.1 >> "%LOG_FILE%"
echo [%TIME%] Usuario: %USERNAME% >> "%LOG_FILE%"
echo [%TIME%] Sistema: %COMPUTERNAME% >> "%LOG_FILE%"

:: Verificar e criar arquivo de estatísticas
if not exist "%USERPROFILE%\CleanTools_stats.txt" (
    echo total_runs=0 > "%USERPROFILE%\CleanTools_stats.txt"
    echo last_run=%DATE% %TIME% >> "%USERPROFILE%\CleanTools_stats.txt"
)

:: Atualizar estatísticas
set /a total_runs=0
for /f "usebackq tokens=2 delims==" %%a in ("%USERPROFILE%\CleanTools_stats.txt") do (
    if "%%a" neq "" set /a total_runs=%%a
)
set /a total_runs+=1
echo total_runs=!total_runs! > "%USERPROFILE%\CleanTools_stats.txt"
echo last_run=%DATE% %TIME% >> "%USERPROFILE%\CleanTools_stats.txt"

:: Menu principal melhorado
:menu
cls
echo ==================================================
echo         MANUTENCAO COMPLETA DO WINDOWS v3.1
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
set /p "opcao=Escolha uma opcao: "

if "!opcao!"=="1" goto limpeza
if "!opcao!"=="2" goto reparo
if "!opcao!"=="3" goto otimizacao
if "!opcao!"=="4" goto atualizacao
if "!opcao!"=="5" goto avancado
if "!opcao!"=="6" goto relatorio
if "!opcao!"=="7" goto configuracoes
if "!opcao!"=="8" goto end
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
set /p "escolha=Escolha o tipo de limpeza: "

if "!escolha!"=="1" goto limpeza_basica
if "!escolha!"=="2" goto limpeza_completa
if "!escolha!"=="3" goto menu
echo Opcao invalida!
pause
goto limpeza

:limpeza_basica
echo.
echo [%TIME%] Iniciando limpeza basica >> "%LOG_FILE%"
call :show_progress "Iniciando limpeza basica..."

:: Limpeza de arquivos temporários
if exist "%temp%" (
    del /q /f /s "%temp%\*.*" 2>nul
    rd /q /s "%temp%" 2>nul
    md "%temp%" 2>nul
)

if exist "C:\Windows\Temp" del /q /f /s "C:\Windows\Temp\*.*" 2>nul
if exist "%USERPROFILE%\AppData\Local\Temp" del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

call :show_progress "Limpeza basica concluida!"
echo [%TIME%] Limpeza basica concluida >> "%LOG_FILE%"
pause
goto limpeza

:limpeza_completa
echo.
echo [%TIME%] Iniciando limpeza completa >> "%LOG_FILE%"
call :show_progress "Iniciando limpeza completa..."

:: Criar ponto de restauração
call :create_restore_point

:: Limpeza completa
if exist "%temp%" (
    del /q /f /s "%temp%\*.*" 2>nul
    rd /q /s "%temp%" 2>nul
    md "%temp%" 2>nul
)

if exist "C:\Windows\Temp" del /q /f /s "C:\Windows\Temp\*.*" 2>nul
if exist "%USERPROFILE%\AppData\Local\Temp" del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
if exist "C:\Users\Public\Temp" del /q /f /s "C:\Users\Public\Temp\*.*" 2>nul

:: Limpeza de cache
if exist "C:\Windows\Prefetch" del /q /f /s "C:\Windows\Prefetch\*.*" 2>nul
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul

:: Limpeza da Lixeira
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" 2>nul

:: Limpeza de disco
if exist "C:\Windows\System32\cleanmgr.exe" (
    cleanmgr /sagerun:1 >nul 2>&1
)

call :show_progress "Limpeza completa concluida!"
echo [%TIME%] Limpeza completa concluida >> "%LOG_FILE%"
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
set /p "escolha=Escolha uma opcao: "

if "!escolha!"=="1" goto startup_manager
if "!escolha!"=="2" goto service_optimizer
if "!escolha!"=="3" goto security_check
if "!escolha!"=="4" goto disk_health
if "!escolha!"=="5" goto full_report
if "!escolha!"=="6" goto menu
echo Opcao invalida!
pause
goto avancado

:startup_manager
echo.
echo [%TIME%] Iniciando gerenciador de startup >> "%LOG_FILE%"
echo  Programas que iniciam com o Windows:
echo.
wmic startup get caption, command 2>nul | more
echo.
pause
goto avancado

:service_optimizer
echo.
echo [%TIME%] Iniciando otimizador de servicos >> "%LOG_FILE%"
echo  Servicos desnecessarios que podem ser desativados:
echo.
echo  - DiagTrack (Telemetria)
echo  - dmwappushservice (Push de notificacoes)
echo  - Fax (Servico de fax)
echo.
echo 1 - Desativar servicos desnecessarios
echo 2 - Voltar
set /p "choice=Escolha: "

if "!choice!"=="1" (
    sc config DiagTrack start= disabled >nul 2>&1
    sc config dmwappushservice start= disabled >nul 2>&1
    echo Servicos desativados com sucesso!
    echo [%TIME%] Servicos desnecessarios desativados >> "%LOG_FILE%"
)
pause
goto avancado

:security_check
echo.
echo [%TIME%] Iniciando verificacao de seguranca >> "%LOG_FILE%"
echo  Status do Firewall:
netsh advfirewall show allprofiles state 2>nul | findstr "Estado"
echo.
echo  Antivirus instalado:
wmic /namespace:\\root\securitycenter2 path antivirusproduct get displayName 2>nul
echo.
pause
goto avancado

:disk_health
echo.
echo [%TIME%] Iniciando analise de disco >> "%LOG_FILE%"
echo  Status dos discos:
wmic diskdrive get status,model,size 2>nul
echo.
echo  Espaco em disco disponivel:
for /f "skip=1" %%d in ('wmic logicaldisk where "drivetype=3" get deviceid^, freespace^, size 2^>nul') do (
    if not "%%d"=="" echo %%d
)
echo.
pause
goto avancado

:full_report
echo.
echo [%TIME%] Gerando relatorio tecnico >> "%LOG_FILE%"
echo  Gerando relatorio completo...
systeminfo > "%TEMP%\system_info.txt" 2>nul
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
set /p "escolha=Escolha: "

if "!escolha!"=="1" goto health_report
if "!escolha!"=="2" goto disk_report
if "!escolha!"=="3" goto programs_report
if "!escolha!"=="4" goto last_run_report
if "!escolha!"=="5" goto menu
echo Opcao invalida!
pause
goto relatorio

:health_report
echo.
echo  Relatorio de Saude do Sistema:
echo.
systeminfo 2>nul | findstr /C:"Memoria" /C:"Processador" /C:"Sistema"
echo.
pause
goto relatorio

:disk_report
echo.
echo  Espaco em disco:
echo.
setlocal
for /f "skip=1 tokens=1,2,3" %%a in ('wmic logicaldisk where "drivetype=3" get deviceid^, freespace^, size 2^>nul') do (
    if not "%%a"=="" (
        set /a free_mb=%%b/1048576 2>nul
        set /a total_mb=%%c/1048576 2>nul
        set /a used_pct=100 2>nul
        if !total_mb! gtr 0 (
            set /a used_pct=100*!free_mb!/!total_mb! 2>nul
        )
        echo Disco %%a: !free_mb!MB livres de !total_mb!MB (!used_pct!%% livre)
    )
)
endlocal
echo.
pause
goto relatorio

:programs_report
echo.
echo  Programas instalados (ultimos 10):
echo.
wmic product get name, version 2>nul | head -n 11
echo.
pause
goto relatorio

:last_run_report
echo.
echo  Ultima execucao do CleanTools:
if exist "%USERPROFILE%\CleanTools_stats.txt" (
    type "%USERPROFILE%\CleanTools_stats.txt" 2>nul
) else (
    echo Nenhum registro encontrado.
)
echo.
pause
goto relatorio

:: ==================================================
:: FUNÇÕES AUXILIARES IMPLEMENTADAS
:: ==================================================

:show_progress
setlocal
set message=%~1
set /a width=30
set "bar="
for /l %%i in (1,1,!width!) do set "bar=!bar!="
echo.
echo !message!
echo [!bar!]
timeout /t 1 /nobreak >nul
endlocal
exit /b 0

:create_restore_point
echo [%TIME%] Criando ponto de restauracao >> "%LOG_FILE%"
powershell -Command "Checkpoint-Computer -Description \"CleanTools Plus Restore Point\" -RestorePointType MODIFY_SETTINGS" 2>nul
if !errorlevel! equ 0 (
    echo Ponto de restauracao criado com sucesso!
    echo [%TIME%] Ponto de restauracao criado >> "%LOG_FILE%"
) else (
    echo Nao foi possivel criar ponto de restauracao
    echo [%TIME%] Erro ao criar ponto de restauracao >> "%LOG_FILE%"
)
exit /b 0

:: ==================================================
:: FUNÇÕES EXISTENTES (mantidas para compatibilidade)
:: ==================================================

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
echo y | chkdsk /f /r >nul 2>&1
echo.
echo  Reparando componentes do Windows Update...
dism /Online /Cleanup-Image /StartComponentCleanup
echo.
echo  Corrigindo permissões de arquivos do sistema...
powershell -Command "secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose" 2>nul

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
set /p "escolha=Escolha o tipo de otimizacao: "

if "!escolha!"=="1" goto otimizacao_basica
if "!escolha!"=="2" goto otimizacao_desempenho
if "!escolha!"=="3" goto otimizacao_rede
if "!escolha!"=="4" goto gerenciar_armazenamento_reservado
if "!escolha!"=="5" goto menu
echo Opcao invalida!
pause
goto otimizacao

:otimizacao_basica
echo.
echo  Aplicando otimizacoes basicas...

:: Acelera menus
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

:: Reduz tempo de resposta para aplicativos travados
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul 2>&1

:: Acelera desligamento
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul 2>&1

:: Desativa relatórios de erro
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1

:: Reinicia o Explorer para aplicar mudanças
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe >nul 2>&1

echo.
echo  Otimizacoes basicas aplicadas!
pause
goto otimizacao

:otimizacao_desempenho
echo.
echo  Aplicando otimizacoes de desempenho...

:: Configura plano de energia para Alto Desempenho
powercfg /s SCHEME_MIN >nul 2>&1

:: Desativa efeitos visuais
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuAnimation /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1

:: Remove sombra de janelas
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1

:: Otimizações para SSD
fsutil behavior query DisableDeleteNotify >nul 2>&1 && (
    fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
)

:: Desativa serviços desnecessários
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc stop dmwappushservice >nul 2>&1

echo.
echo  Otimizacoes de desempenho aplicadas!
pause
goto otimizacao

:otimizacao_rede
echo.
echo  Aplicando otimizacoes de rede...

:: Melhora desempenho da rede
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1

:: Redefinição de configuração de rede
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1

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
set /p "escolha=Escolha uma opcao: "

if "!escolha!"=="1" goto verificar_armazenamento_reservado
if "!escolha!"=="2" goto habilitar_armazenamento_reservado
if "!escolha!"=="3" goto desabilitar_armazenamento_reservado
if "!escolha!"=="4" goto otimizacao
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
set /p "escolha=Escolha uma opcao: "

if "!escolha!"=="1" goto instalar_gerenciadores
if "!escolha!"=="2" goto atualizar_tudo
if "!escolha!"=="3" goto atualizar_winget
if "!escolha!"=="4" goto atualizar_choco
if "!escolha!"=="5" goto atualizar_windows
if "!escolha!"=="6" goto menu
echo Opcao invalida!
pause
goto atualizacao

:instalar_gerenciadores
echo.
echo  Verificando e instalando Winget...
where winget >nul 2>&1 || (
    echo Instalando Winget...
    powershell -Command "Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile winget.appxbundle -ErrorAction SilentlyContinue" 2>nul
    powershell -Command "Add-AppxPackage winget.appxbundle -ErrorAction SilentlyContinue" 2>nul
)

echo  Verificando e instalando Chocolatey...
where choco >nul 2>&1 || (
    echo Instalando Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) -ErrorAction SilentlyContinue" 2>nul
)

echo.
echo  Instalação concluída!
pause
goto atualizacao

:atualizar_tudo
echo.
echo  Atualizando todos os programas...

where winget >nul 2>&1 && winget upgrade --all --silent --accept-package-agreements --accept-source-agreements || echo  Winget não encontrado, pulando etapa.
where choco >nul 2>&1 && choco upgrade all -y || echo  Chocolatey não encontrado, pulando etapa.
powershell -Command "Start-Process powershell -ArgumentList '-Command Install-WindowsUpdate -AcceptAll -AutoReboot' -Verb RunAs" 2>nul

echo.
echo  Atualização concluída!
pause
goto atualizacao

:atualizar_winget
echo.
echo  Atualizando programas via Winget...
where winget >nul 2>&1 && winget upgrade --all --silent --accept-package-agreements --accept-source-agreements || echo  Winget não encontrado!
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
powershell -Command "Start-Process powershell -ArgumentList '-Command Install-WindowsUpdate -AcceptAll -AutoReboot' -Verb RunAs" 2>nul
echo.
echo  Atualização concluída!
pause
goto atualizacao

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
set /p "escolha=Escolha uma opcao: "

if "!escolha!"=="1" goto toggle_reboot
if "!escolha!"=="2" goto toggle_verbose
if "!escolha!"=="3" goto reset_config
if "!escolha!"=="4" goto menu
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

:limpar_cache_impressao
echo.
echo  Parando serviço de spooler de impressão...
net stop spooler 2>nul
echo.
echo  Limpando arquivos de cache de impressão...
del /q /f /s "%systemroot%\system32\spool\printers\*.*" 2>nul
echo.
echo  Iniciando serviço de spooler de impressão...
net start spooler 2>nul
echo.
echo  Cache de impressão limpo com sucesso!
exit /b 0

:: ==================================================
:: FINALIZAÇÃO
:: ==================================================

:end
echo [%TIME%] CleanTools Plus finalizado >> "%LOG_FILE%"
echo.
echo Obrigado por usar CleanTools Plus v3.1!
echo.
pause
exit /b 0
