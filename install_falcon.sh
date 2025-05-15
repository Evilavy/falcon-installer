#!/bin/bash

set -e  # Stop on error

DOWNLOAD_PATH="$HOME/Downloads/FalconSensor.pkg"

# Télécharger depuis Synology (lien direct)
echo "Téléchargement du package Falcon depuis le NAS Synology..."
curl -L -o "$DOWNLOAD_PATH" "https://github.com/Evilavy/falcon-installer/raw/main/FalconSensor.pkg"

echo "Téléchargement terminé : $(ls -lh "$DOWNLOAD_PATH")"
echo ""

# Demander confirmation
read -p "Souhaites-tu installer Falcon maintenant ? (oui/non) : " reponse

if [[ "$reponse" == "oui" || "$reponse" == "y" || "$reponse" == "O" ]]; then
    echo "Installation en cours..."
    sudo installer -verboseR -package "$DOWNLOAD_PATH" -target /

    echo "Configuration Falcon..."
    sudo /Applications/Falcon.app/Contents/Resources/falconctl grouping-tags set MOBIAPPS-Tag-MAC-Standard
    sudo /Applications/Falcon.app/Contents/Resources/falconctl license 14C4929A5ABD491191E6419AD3DD7C4C-C1
    sudo /Applications/Falcon.app/Contents/Resources/falconctl load

    echo "✅ Installation et configuration terminées avec succès."
else
    echo "❌ Installation annulée par l'utilisateur. Aucune modification n'a été faite."
fi
