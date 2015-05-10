# zte-openc-flash-modem
Scripts permettant de flasher la partition modem du ZTE Open C (FR uniquement) sous Linux, et Windows.

ZTE fournit un outil pour rooter l'Open C FR. Cependant, l'exécution de cet outil met ou remet une version buggué du firmware modem, provocant aléatoirement un plantage du téléphone en cours d'appel.
Ce bug est corrigé dans le firmware fournit par la dernière MAJ du constructeur, qui n'est donc pas incluse dans le pack root. Par ailleurs, cette MAJ est resté un certain temps, téléchargeable uniquement depuis le téléphone, via l'application de Mise-à-jour ZTE.

Suite à la publication par ZTE de la dernière MAJ, ces scripts ont été créé pour simplifier l'application du dernier firmware modem sur les Open C FR rooté.

Exécution du script propre à votre OS:
	Téléchargez le script, extrayez-le dans un dossier et positionnez-vous dans ce dossier (cd dossier_contenant_le_script).
	Si vous êtes déjà en possession de la dernière MAJ, il vous suffit d'en extraire le fichier NON-HLOS.bin, et de le placer dans le même répertoire que le script
	Sinon, merci de lire ce qui suit :
	Sous Linux	
		Exécutez simplement le script. Ce dernier vous proposera de récupérer la dernière MAJ, et fera l'extraction à votre place
	Sous Windows
		Vous devrez télécharger manuellement la dernière MAJ, et en extraire le fichier NON-HLOS.bin. Elle est disponible ici : http://download.ztedevice.com/UpLoadFiles/product/643/5522/soft/2015042909034130.zip

L'ensemble des recherches ayant permis d'aboutir à ce script sont disponible sur le forum MozFR à cette adresse : https://forums.mozfr.org/viewtopic.php?f=33&t=122597.


Remarques pour les Open C EU :
Si vous rencontrez le même problème, vous pouvez prendre connaissance du bug suivant : https://bugzilla.mozilla.org/show_bug.cgi?id=1017604#c27.
Il semblerait en effet qu'un possesseur d'Open C EU (eBay) rencontrant le prolème, ait flashé la partition modem de son appareil avec ce firmware (fournis officiellement pour l'Open C FR), et que le problème ait été résolu.

RAPPELEZ-VOUS QUE CECI N'EST PAS OFFICIEL ET DONC PAS SUPPORTE SUR L'OPEN C EU. VOUS EFFECTUEREZ CETTE MANIPULATION A VOS RISQUES ET PERILS
