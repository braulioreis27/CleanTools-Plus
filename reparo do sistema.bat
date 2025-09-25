:MENU2
cls
echo =======================================
echo     REPARO DO SISTEMA AVANCADO
echo =======================================
echo [5] Verificar integridade da imagem do Windows (DISM /CheckHealth)
echo [21] Scan detalhado da imagem (DISM /ScanHealth)
echo [22] Reparar componentes do Windows (DISM /RestoreHealth)
echo [23] Verificar e reparar arquivos do sistema (SFC /scannow)
echo [24] Reparo sequencial recomendado (DISM + SFC)
echo  Voltar ao menu principal
echo =======================================
set /p re="Escolha uma opcao: "

if "%re%"=="1" goto CHECKHEALTH
if "%re%"=="2" goto SCANHEALTH
if "%re%"=="3" goto RESTOREHEALTH
if "%re%"=="4" goto SFC
if "%re%"=="5" goto REPAIRALL
if "%re%"=="0" goto MENU
goto MENU2

:CHECKHEALTH
cls
echo Verificando integridade da imagem do Windows com DISM...
DISM /Online /Cleanup-Image /CheckHealth
pause
goto MENU2

:SCANHEALTH
cls
echo Escaneando a saude da imagem do Windows com DISM...
DISM /Online /Cleanup-Image /ScanHealth
pause
goto MENU2

:RESTOREHEALTH
cls
echo Reparando componentes do Windows (DISM /RestoreHealth)...
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto MENU2

:SFC
cls
echo Verificando e reparando arquivos do sistema (SFC /scannow)...
sfc /scannow
pause
goto MENU2

:REPAIRALL
cls
echo Executando sequencia recomendada: DISM (ScanHealth) -> DISM (RestoreHealth) -> SFC
echo Escaneando a saude da imagem...
DISM /Online /Cleanup-Image /ScanHealth
echo Reparando componentes da imagem...
DISM /Online /Cleanup-Image /RestoreHealth
echo Verificando e reparando arquivos do sistema...
sfc /scannow
echo Concluido. Recomenda-se reiniciar o sistema.
pause
goto MENU2
