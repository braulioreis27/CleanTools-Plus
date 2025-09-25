:MENU4
cls
echo =======================================
echo            BACKUP DE DRIVERS
echo =======================================
echo [1] Backup dos drivers atuais (Exporta para pasta BackupDrivers)
echo [2] Restaurar drivers a partir do backup (BackupDrivers)
echo [3] Desativar atualizacoes automaticas de drivers via Windows Update
echo [4] Verificar dispositivos com problemas
echo [5] Abrir Gerenciador de Dispositivos (Device Manager)
echo [0] Voltar ao menu principal
echo =======================================
set /p drvopt="Escolha uma opcao: "

if "%drvopt%"=="1" goto BACKUP_DRIVERS
if "%drvopt%"=="2" goto RESTORE_DRIVERS
if "%drvopt%"=="3" goto DISABLE_DRIVER_UPDATES
if "%drvopt%"=="4" goto DEVICES_PROBLEMS
if "%drvopt%"=="5" goto OPEN_DEV_MGR
if "%drvopt%"=="0" goto MENU
goto MENU4

:BACKUP_DRIVERS
cls
echo === Backup dos drivers atuais ===
set backupdir=%USERPROFILE%\Desktop\BackupDrivers
if not exist "%backupdir%" mkdir "%backupdir%"
echo Exportando drivers para %backupdir% ...
dism /online /export-driver /destination:"%backupdir%"
echo Backup concluido!
pause
goto MENU4

:RESTORE_DRIVERS
cls
echo === Restaurar drivers a partir do backup ===
set backupdir=%USERPROFILE%\Desktop\BackupDrivers
if not exist "%backupdir%" (
    echo Pasta de backup nao encontrada: %backupdir%
    pause
    goto MENU4
)
echo Restaurando drivers da pasta %backupdir% ...
pnputil /scan-devices
pnputil /add-driver "%backupdir%\*.inf" /subdirs /install
echo Restauracao concluida (alguns dispositivos podem requerer reinicio).
pause
goto MENU4

:DISABLE_DRIVER_UPDATES
cls
echo === Desativar atualizacoes automaticas de drivers via Windows Update ===
:: Configurar politica de grupo via registro para desabilitar atualizacoes automaticas de driver
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f
echo Atualizacoes automatizadas de drivers desativadas.
pause
goto MENU4

:DEVICES_PROBLEMS
cls
echo === Verificar dispositivos com problemas ===
echo Abrindo Gerenciador de Dispositivos focado em dispositivos com problema...
start devmgmt.msc
echo (Filtros manuais para dispositivos com problema devem ser aplicados no Gerenciador)
pause
goto MENU4

:OPEN_DEV_MGR
cls
echo === Abrindo Gerenciador de Dispositivos ===
start devmgmt.msc
pause
goto MENU4
