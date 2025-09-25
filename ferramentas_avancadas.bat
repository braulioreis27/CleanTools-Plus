@echo off
:: Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script precisa ser executado como administrador.
    pause
    exit /b
)

:MENU6
cls
echo =======================================
echo         FERRAMENTAS AVANCADAS
echo =======================================
echo [1] Gerenciador de Tarefas Avancadas (Process Explorer)
echo [2] Editor de Registro (regedit)
echo [3] Gerenciador de Dispositivos
echo [4] Visualizador de Eventos
echo [5] Limpar Cache DNS
echo [6] Abrir Monitor de Recursos (Resource Monitor)
echo [7] Ver uso de CPU, RAM e Disco em tempo real (Tasklist + WMIC)
echo [8] Prompt de Comando Admin
echo [9] PowerShell Admin
echo [10] Diagnostico de Rede (Network Troubleshooter)
echo [11] Diagnostico e Reparo de Disco (chkdsk e sfc)
echo [12] Gerenciamento Avancado de Servicos
echo [13] Listar Processos por uso (CPU/Memoria)
echo [14] Abrir Configuracoes de Rede e Firewall
echo [0] Voltar ao menu principal
echo =======================================
set /p advopt="Escolha uma opcao: "

if "%advopt%"=="1" goto TASKEXPLORER
if "%advopt%"=="2" goto REGEDIT
if "%advopt%"=="3" goto DEVICEMGR
if "%advopt%"=="4" goto EVENTVIEWER
if "%advopt%"=="5" goto DNScLEAN
if "%advopt%"=="6" goto RESOURCEMON
if "%advopt%"=="7" goto SYSINFO
if "%advopt%"=="8" goto CMDADMIN
if "%advopt%"=="9" goto PSADMIN
if "%advopt%"=="10" goto NETDIAG
if "%advopt%"=="11" goto DISKDIAG
if "%advopt%"=="12" goto SERVICE_MGR
if "%advopt%"=="13" goto PROCESS_LIST
if "%advopt%"=="14" goto NETWORK_FIREWALL
if "%advopt%"=="0" goto MENU
goto MENU6

:TASKEXPLORER
cls
echo Abrindo Process Explorer...
if exist "%~dp0procexp.exe" (
    start "" "%~dp0procexp.exe"
) else (
    echo Process Explorer nao encontrado.
    echo Baixe em: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
)
pause
goto MENU6

:REGEDIT
cls
echo Abrindo Editor do Registro (regedit)...
start regedit
goto MENU6

:DEVICEMGR
cls
echo Abrindo Gerenciador de Dispositivos...
start devmgmt.msc
goto MENU6

:EVENTVIEWER
cls
echo Abrindo Visualizador de Eventos...
start eventvwr.msc
goto MENU6

:DNScLEAN
cls
echo Limpando cache DNS...
ipconfig /flushdns >nul
echo Cache DNS limpo com sucesso!
echo Log gerado em %USERPROFILE%\dns_flush_log.txt
echo %date% %time% - DNS cache flushed successfully. >> "%USERPROFILE%\dns_flush_log.txt"
pause
goto MENU6

:RESOURCEMON
cls
echo Abrindo Monitor de Recursos...
start resmon.exe
goto MENU6

:SYSINFO
cls
echo Uso de CPU:
wmic cpu get loadpercentage
echo.
echo Memoria Livre (KB):
wmic OS get FreePhysicalMemory /format:list
echo.
echo Processos Ativos:
tasklist /FO TABLE /NH
echo.
echo Gerando log de processos em %USERPROFILE%\process_list_log.txt...
tasklist /FO LIST > "%USERPROFILE%\process_list_log.txt"
pause
goto MENU6

:CMDADMIN
cls
echo Abrindo Prompt de Comando com privilegios administrativos...
start cmd.exe
goto MENU6

:PSADMIN
cls
echo Abrindo PowerShell com privilegios administrativos...
start powershell.exe
goto MENU6

:NETDIAG
cls
echo Abrindo ferramenta de diagnostico de rede...
start msdt.exe /id NetworkDiagnosticsNetworkAdapter
goto MENU6

:DISKDIAG
cls
echo Executando diagnostico e reparo de disco...
echo Iniciando chkdsk no drive C: (pode levar tempo, consulte pausa para cancelar)...
chkdsk C: /f /r
echo Executando verificação de arquivos do sistema (sfc /scannow)...
sfc /scannow
pause
goto MENU6

:SERVICE_MGR
cls
echo Listando servicos em execucao...
sc query state= all > "%USERPROFILE%\services_list.txt"
echo Servicos listados em %USERPROFILE%\services_list.txt
echo Para iniciar, parar ou reiniciar um servico use:
echo sc start [nome_servico]
echo sc stop [nome_servico]
echo sc stop [nome_servico] && sc start [nome_servico]
pause
goto MENU6

:PROCESS_LIST
cls
echo Listando processos por uso de CPU (ordenado) - top 10:
echo (Pode demorar alguns segundos)...
powershell "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Format-Table -AutoSize" 
echo.
echo Listando processos por uso de memoria (ordenado) - top 10:
powershell "Get-Process | Sort-Object WS -Descending | Select-Object -First 10 | Format-Table -AutoSize"
pause
goto MENU6

:NETWORK_FIREWALL
cls
echo Abrindo configuracoes de Rede e Firewall...
start ms-settings:network
start wf.msc
pause
goto MENU6
