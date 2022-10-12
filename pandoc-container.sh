#!/bin/bash

if [ ! $( docker images -q pandoc ) ];
then
    docker build -t pandoc .
fi

# Identifier le répertoire où le fichier source se trouve
SOURCE=$(readlink -f $3)
SOURCEPATH=`dirname $SOURCE`
SOURCEFILE=`basename $SOURCE`

# Répertoire où déposer le fichier créé
if [ ! "$4" ];
then 
    DESTPATH=$SOURCEPATH
    DESTFILE=""
else
    DESTPATH=`dirname $4`
    DESTFILE=`basename $4`
fi

# Executer le conteneur en tant que l'usager en cours du système hôte
CURRENT_USER=$(id -u)
CURRENT_GROUP=$(id -g)

docker run --rm --security-opt label=disable --userns=keep-id --user $CURRENT_USER:$CURRENT_GROUP -v ${SOURCEPATH}:/app/shared/source -v ${DESTPATH}:/app/shared/dest pandoc $1 $2 /app/shared/source/$SOURCEFILE /app/shared/dest/$DESTFILE
