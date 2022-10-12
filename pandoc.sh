#!/bin/bash

Help()
{
   # Montrer bloc aide
   echo
   echo "Conversion de documents via Pandoc."
   echo
   echo "Syntaxe: ./pandoc.sh FORMAT THEME SOURCE [DESTINATION]"
   echo "Paramètres:"
   echo "FORMAT:        Format de document cible [html ou pdf]."
   echo "THEME:         Nom du thème à appliquer. Nom du répertoire dans /themes."
   echo "SOURCE:        Document source."
   echo "DESTINATION:   Optionnel, chemin du document converti. Le nom du document source avec l'extension choisie sera utilisé si non spécifié."
   echo
   echo "Options:"
   echo "h     Afficher l'aide."
   echo
}

# Options

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

# Paramètres

FORMAT=$1

# Theme
if [ ! "$2" ];
then 
    echo "Nombre de paramètre invalide"
    Help
    exit 255
else THEME=$2
fi

# Document source
if [ ! "$3" ];
then 
    echo "Nombre de paramètre invalide"
    Help
    exit 255
else INPUT=$3
fi

if [ ! "$4" ];
then OUTPUT=$INPUT
else OUTPUT=$4
fi

#Trouver le répertoire de l'éxécutable pour retrouver les thèmes
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

#Arrêter immédiatement sur erreur
set -e

#Formats de conversion supportés
case $FORMAT in
    pdf)
        OUTPUT="${OUTPUT%.*}.pdf"
        pandoc -s $INPUT -c ${SCRIPTPATH}/themes/${THEME}/style.css --self-contained --template ${SCRIPTPATH}/themes/${THEME}/templatepdf.html --resource-path=${SCRIPTPATH} --pdf-engine wkhtmltopdf -V margin-left=80px -V margin-right=80px -V margin-top=80px -V margin-bottom=80px  -V header-html=${SCRIPTPATH}/themes/${THEME}/headerpdf.html -V footer-html=${SCRIPTPATH}/themes/${THEME}/footerpdf.html -V page-size=Letter -o $OUTPUT
    ;;
    html)
        OUTPUT="${OUTPUT%.*}.html"
        pandoc -s $INPUT -c ${SCRIPTPATH}/themes/${THEME}/style.css --self-contained --template ${SCRIPTPATH}/themes/${THEME}/templatehtml.html --resource-path=${SCRIPTPATH} -o $OUTPUT
    ;;
    *)
        echo -e "Format non supporté"
        exit 255
    ;;
esac

status=$?
if [ $status -eq 0 ]; 
then
    echo "Document généré avec succès: $OUTPUT"
else
    echo "Erreur: Le document n'a pas été généré: Code de sortie Pandoc: $status"
fi
