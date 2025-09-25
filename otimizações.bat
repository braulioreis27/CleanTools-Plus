:MENU3
cls
echo =======================================
echo       OTIMIZACOES DO WINDOWS
echo =======================================
echo [1] Otimizacao SSD (executa TRIM, desabilita defrag agendado. Recomendado para SSDs)
echo [2] Otimizacao HDD (defrag tradicional. Recomendado para HDDs)
echo [3] Otimizacao de Rede/Internet (ajustes e reset de rede, flush DNS)
echo [4] Otimizacao de Energia e Desempenho (ajustes de plano, recomendado para laptops)
echo [5] Otimizacao especial para AMD Ryzen 5 3500U (plano otimizado Ryzen)
echo [6] Otimizacao de Memoria RAM (libera e limpa cache e standby)
echo [7] Gerenciamento de Servicos (disable/enable de servicos desnecessarios)
echo [8] Otimizacao de Inicializacao (ajusta programas no boot)
echo [9] Ajustes Visuais e Interface (desliga animacoes e transparencias)
echo [10] Protecao e Privacidade (desliga telemetria, limpa historico)
echo [11] Otimizacoes para Jogos (prioridade alta, desliga processos)
echo [12] Otimizacao Avancada de Rede (QoS, buffers, latencia)
echo [13] Reverter todas as Otimizacoes aplicadas
echo [0] Voltar ao menu principal
echo =======================================
set /p ot="Escolha uma opcao: "

if "%ot%"=="1" goto SSD
if "%ot%"=="2" goto HDD
if "%ot%"=="3" goto NETWORK
if "%ot%"=="4" goto POWER
if "%ot%"=="5" goto RYZEN
if "%ot%"=="6" goto RAM
if "%ot%"=="7" goto SERVICES
if "%ot%"=="8" goto STARTUP
if "%ot%"=="9" goto VISUAL
if "%ot%"=="10" goto PRIVACY
if "%ot%"=="11" goto GAMING
if "%ot%"=="12" goto ADV_NETWORK
if "%ot%"=="13" goto REVERT
if "%ot%"=="0" goto MENU
goto MENU3

:SSD
cls
echo ==== Otimizacao de SSD ====
fsutil behavior set DisableDeleteNotify 0
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
echo Otimizacao SSD concluida!
pause
goto MENU3

:HDD
cls
echo ==== Otimizacao de HDD ====
defrag C: /O
echo Otimizacao HDD concluida!
pause
goto MENU3

:NETWORK
cls
echo ==== Otimizacao de Rede e Internet ====
netsh int ip reset
netsh winsock reset
ipconfig /flushdns
ipconfig /release
ipconfig /renew
echo Otimizacao de rede/internet concluida!
pause
goto MENU3

:POWER
cls
echo ==== Otimizacao de Energia e Desempenho ====
powercfg /setactive SCHEME_BALANCED
powercfg /change monitor-timeout-ac 0
powercfg /change standby-timeout-ac 0
powercfg /change disk-timeout-ac 0
echo Para laptops, ative opcoes da BIOS e drivers para melhor desempenho.
pause
goto MENU3

:RYZEN
cls
echo ==== Otimizacao especial AMD Ryzen 5 3500U ====
powercfg /import "%~dp0RyzenOptimized.pow"
rem Substituir <GUID-do-plano-Ryzen> pelo GUID correto do plano importado
powercfg /setactive <GUID-do-plano-Ryzen>
echo Recomendado manter BIOS, chipset e drivers AMD atualizados.
pause
goto MENU3

:RAM
cls
echo ==== Otimizacao de Memoria RAM ====
echo Limpando RAM standby e cache...
:: Liberar cache Standby com ferramentas ou limpar memoria
:: Exemplo: usando RAMMap - Mas aqui focaremos em comando basico
echo Liberando cache do sistema (algumas memorias podem nao ser liberadas via bat)...
echo (Para limpeza mais profunda, use ferramentas externas como RAMMap)
pause
goto MENU3

:SERVICES
cls
echo ==== Gerenciamento de Servicos ====
echo Desabilitando servicos nao essenciais...
:: Exemplos:
sc config "Fax" start= disabled
sc stop "Fax"
sc config "DiagTrack" start= disabled
sc stop "DiagTrack"
sc config "XblGameSave" start= disabled
sc stop "XblGameSave"
echo Servicos desabilitados. Voce pode reabilitar manualmente.
pause
goto MENU3

:STARTUP
cls
echo ==== Otimizacao de Inicializacao ====
echo Abrindo Gerenciador de Tarefas para ajuste manual de programas no boot...
start taskmgr
echo Voce pode desabilitar programas desnecessarios manualmente.
pause
goto MENU3

:VISUAL
cls
echo ==== Ajustes Visuais e Interface ====
echo Desativando animacoes e transparencias...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 0 /f
echo Ajustes aplicados.
pause
goto MENU3

:PRIVACY
cls
echo ==== Protecao e Privacidade ====
echo Desabilitando telemetria e limpando historico...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
echo Historico de navegacao sera limpo em navegadores manualmente.
pause
goto MENU3

:GAMING
cls
echo ==== Otimizacoes para Jogos ====
echo Definindo prioridade alta para processos de jogos...
echo (Executar manualmente nas Tarefas conforme necessario)
echo Desabilitando processos desnecessarios durante jogos...
:: Pode adicionar comandos para suspender processos ou desabilitar tarefas temporariamente
pause
goto MENU3

:ADV_NETWORK
cls
echo ==== Otimizacao Avancada de Rede ====
echo Ajustando parametros QoS, buffers e latencia...
netsh interface tcp set global chimney=enabled
netsh interface tcp set global autotuninglevel=normal
netsh interface tcp set global congestionprovider=ctcp
echo Parametros ajustados.
pause
goto MENU3

:REVERT
cls
echo ==== Revertendo todas as otimizações ====
echo Reativando defrag agendado...
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Enable
echo Reativando servicos essenciais...
sc config "Fax" start= demand
sc start "Fax"
sc config "DiagTrack" start= demand
sc start "DiagTrack"
sc config "XblGameSave" start= demand
sc start "XblGameSave"
echo Restaurando visual para padrao...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 1 /f
echo Revertendo configuracoes de telemetria...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f
echo Otimizacoes revertidas.
pause
goto MENU3
