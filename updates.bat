:MENU5
cls
echo =======================================
echo          ATUALIZACOES DE PROGRAMAS
echo =======================================
echo [1] Configurar Windows Update para atualizacoes de seguranca apenas
echo [2] Verificar atualizacoes via winget
echo [3] Verificar atualizacoes via chocolatey
echo [4] Verificar atualizacoes via winget e chocolatey juntos
echo [0] Voltar ao menu principal
echo =======================================
set /p upopt="Escolha uma opcao: "

if "%upopt%"=="1" goto WINUPDATE_SECURITY
if "%upopt%"=="2" goto WINGET_UPDATE
if "%upopt%"=="3" goto CHOCO_UPDATE
if "%upopt%"=="4" goto WINGET_CHOCO_UPDATE
if "%upopt%"=="0" goto MENU
goto MENU5

:WINUPDATE_SECURITY
cls
echo Configurando Windows Update para baixar apenas atualizacoes de seguranca...
:: Configura o Windows Update para receber apenas updates de seguranca via registro
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions" /t REG_DWORD /d 3 /f >nul 2>&1
echo Windows Update configurado para atualizacoes de seguranca apenas.
pause
goto MENU5

:WINGET_UPDATE
cls
echo Verificando atualizacoes via winget...
winget upgrade
pause
goto MENU5

:CHOCO_UPDATE
cls
echo Verificando atualizacoes via chocolatey...
choco outdated
pause
goto MENU5

:WINGET_CHOCO_UPDATE
cls
echo Verificando atualizacoes via winget e chocolatey...
echo --- Winget ---
winget upgrade
echo.
echo --- Chocolatey ---
choco outdated
pause
goto MENU5
