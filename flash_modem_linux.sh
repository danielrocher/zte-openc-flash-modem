#! /bin/bash

###################################
# MAJ firmware Modem
# Copyright (C) 2015 Micgeri
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
###################################


if [[ $1 == "-h" ||  $1 == "--help" ]]; then
        echo "Ce script permet de flasher la partition firmware de votre Open C" &&
        echo &&
        echo "Utilisation : ${BASH_SOURCE[0]}" &&
        echo "Le fichier sera recherché dans le dossier courant" &&
        exit 0
fi


CHEMIN_FIC=`pwd`
(
		# On vérifie si le firmware est à jour
		FIRMWARE_VER=`adb shell cat /firmware/verinfo/ver_info.txt` || exit
		if [[ $FIRMWARE_VER == "M8610AAAAAWFYD1030103.1" ]]; then
			echo "Le firmware est déjà à jour" &&
			exit 0
		fi

		# On teste la présence du fichier NON-HLOS.bin, et on stocke le résultat en variable
		ls -l "$CHEMIN_FIC"/NON-HLOS.bin > /dev/null 2>&1
		TESTFIC=$?
		# On poursuit l'exécution du script uniquement si le fichier NON-HLOS.bin existe
		if [[ $TESTFIC != "0" ]]; then
				echo '-------------------------------------'
				read -p "Voulez-vous télécharger la mise-à-jour B03 [O/n] ? (n par défaut) " rep
				if [[ $rep == "O" || $rep == "o" ]]; then
						wget -O B03.zip http://download.ztedevice.com/UpLoadFiles/product/643/5522/soft/2015042909034130.zip || (echo "Le téléchargement a échoué, merci de réessayer" && exit 1)
						unzip ./B03.zip &&
						unzip -d ./update_B03 "France OPEN C SD card upgrading instruction & software package(L leclerc telecom)-268280B0304FFOS_FR_ZTE_OPENCV1.0.0B03/update.zip" &&
						cp ./update_B03/NON-HLOS.bin ./NON-HLOS.bin
						rm -rf update_B03 "France OPEN C SD card upgrading instruction & software package(L leclerc telecom)-268280B0304FFOS_FR_ZTE_OPENCV1.0.0B03"
				else
						echo "Merci de placer le fichier NON-HLOS.bin dans le dossier $CHEMIN_FIC"
						exit $TESTFIC
				fi
		fi


        adb shell stop b2g &&
        echo "Arrêt du système [OK]" &&
		
        adb push "$CHEMIN_FIC"/NON-HLOS.bin /data/ &&
        echo "Copie du firmware sur la mémoire du téléphone pour le flash [OK]" &&

        adb shell umount /firmware &&
        echo "Démontage partition /firmware [OK]" &&

        adb shell dd if=/dev/block/platform/msm_sdcc.1/by-name/modem of=/data/NON-HLOS-old.bin &&
        adb pull /data/NON-HLOS-old.bin &&
        echo "Sauvegarde ancienne partition /firmware dans `pwd` [OK]" &&

        adb shell dd if=/data/NON-HLOS.bin of=/dev/block/platform/msm_sdcc.1/by-name/modem &&
        echo "Flashage partition /firmware [OK]" &&

        adb shell rm /data/NON-HLOS.bin &&
        adb shell rm /data/NON-HLOS-old.bin &&
		adb shell sync &&
        adb shell reboot &&
        echo "Nettoyage et redémarrage du telephone [OK]"
) ||
echo "Erreur : Vérifier que votre Open C est relié à votre pc, allumé, et que le débogage distant y est activé"