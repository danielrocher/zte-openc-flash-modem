REM ###################################
REM MAJ firmware Modem
REM Copyright (C) 2015 Micgeri
REM 
REM 
REM This program is free software; you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation; either version 3 of the License, or
REM (at your option) any later version.
REM 
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM 
REM You should have received a copy of the GNU General Public License
REM along with this program; if not, write to the Free Software
REM Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
REM ###################################


@echo off

if "%1"=="-h" GOTO :AIDE
if "%1"=="/h" GOTO :AIDE
if "%1"=="--help" GOTO :AIDE
if "%1"=="/help" GOTO :AIDE
if "%1"=="-?" GOTO :AIDE
if "%1"=="/?" GOTO :AIDE


set CHEMIN_FIC=%cd%

REM On vérifie si le firmware est à jour
set FIRMWARE_VER=`adb shell cat /firmware/verinfo/ver_info.txt`
if "%FIRMWARE_VER%"=="M8610AAAAAWFYD1030103.1" (
	echo Le firmware est deja a jour
	pause
	GOTO :eof
)

REM On poursuit l'execution du script uniquement si le fichier NON-HLOS.bin existe
if NOT EXIST "%CHEMIN_FIC%"\NON-HLOS.bin (
	echo Le fichier NON-HLOS.bin n'existe pas dans le dossier %CHEMIN_FIC%
	pause
	GOTO :eof
)

(
adb shell stop b2g && ^
echo Arret du systeme [OK] && ^
REM
adb push "%CHEMIN_FIC%"\NON-HLOS.bin /data/ && ^
echo Copie du firmware sur la memoire du telephone pour le flash [OK] && ^
REM
adb shell umount /firmware && ^
echo Demontage partition /firmware [OK] && ^
REM
adb shell dd if=/dev/block/platform/msm_sdcc.1/by-name/modem of=/data/NON-HLOS-old.bin && ^
adb pull /data/NON-HLOS-old.bin "%CHEMIN_FIC%" && ^
echo Sauvegarde ancienne partition /firmware et recuperation dans dossier %CHEMIN_FIC% [OK] && ^
REM
adb shell dd if=/data/NON-HLOS.bin of=/dev/block/platform/msm_sdcc.1/by-name/modem && ^
echo Flashage partition /firmware [OK] && ^
REM
adb shell rm /data/NON-HLOS.bin && ^
adb shell rm /data/NON-HLOS-old.bin && ^
adb shell sync && ^
adb shell reboot && ^
echo Nettoyage et redemarrage du telephone [OK]
) || echo Erreur : Verifier que votre Open C est relie a votre pc, allume, et que le debogage distant y est active
pause
GOTO :eof

:AIDE
echo Ce script permet de flasher la partition firmware de votre Open C
echo.
echo Utilisation : %0
echo Le fichier sera recherche dans la dossier courant