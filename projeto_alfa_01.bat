@echo off
color 0A
title Manutenção do Windows 10/11

:MENU
cls
echo =======================================
echo       Manutencao do Windows 10/11
echo =======================================
echo [1] Limpeza Simples
echo [2] Limpeza Completa
echo  Sair
echo =======================================
set /p op="Escolha uma opcao: "

if "%op%"=="1" goto SIMPLES
if "%op%"=="2" goto COMPLETA
if "%op%"=="0" exit
goto MENU

:SIMPLES
cls
echo Limpeza Simples em andamento...
echo [Apaga arquivos temporarios e lixeira]
:: Apagar arquivos temporarios do usuario
del /q /f "%temp%\*" >nul
:: Apagar arquivos temporarios do Windows
del /q /f "C:\Windows\Temp\*" >nul
:: Esvaziar Lixeira
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false
echo Limpeza simples concluida!
pause
goto MENU

:COMPLETA
cls
echo Limpeza Completa em andamento...
echo [Limpeza Avancada do Sistema]
:: Apagar temp usuario
del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul
del /s /f /q "%temp%\*" >nul
:: Apagar prefetch
del /s /f /q "C:\Windows\Prefetch\*.*" >nul
:: Apagar temp sistema
del /s /f /q "C:\Windows\Temp\*.*" >nul
:: Esvaziar Lixeira
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false
:: Limpar cache do Windows Update (Opcional)
net stop wuauserv >nul 2>&1
del /q /f "C:\Windows\SoftwareDistribution\Download\*" >nul
net start wuauserv >nul 2>&1
:: Limpar pasta de Downloads
del /q /f "%USERPROFILE%\Downloads\*" >nul
:: Limpar arquivos .tmp, .log, .bak do sistema
del /f /s /q %systemdrive%\*.tmp >nul
del /f /s /q %systemdrive%\*.log >nul
del /f /s /q %systemdrive%\*.bak >nul
:: Limpar cookies e arquivos recentes
del /f /q "%USERPROFILE%\cookies\*.*" >nul
del /f /q "%USERPROFILE%\recent\*.*" >nul
:: Limpar cache thumbnails
del /q /f "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul
:: Opcional: Executar limpeza de disco
cleanmgr /sagerun:1
echo Limpeza completa concluida!
pause
goto MENU
