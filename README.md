<!-- ENTETE -->
[![img](https://img.shields.io/badge/Lifecycle-Experimental-339999)](https://www.quebec.ca/gouv/politiques-orientations/vitrine-numeriqc/accompagnement-des-organismes-publics/demarche-conception-services-numeriques)
[![License](https://img.shields.io/badge/Licence-LiLiQ--P-blue)](https://github.com/CQEN-QDCE/.github/blob/main/LICENCE.md)

---
![MCN-CQEN](https://github.com/CQEN-QDCE/.github/blob/main/images/mcn.png)
<!-- FIN ENTETE -->

# Scripts et thèmes de conversion de fichiers markdown pour Pandoc.

Script qui permet de convertir un document *markdown* en document html ou pdf en appliquant un thème au document. Les scripts utilisent le projet de conversion universelle [Pandoc](https://pandoc.org/).

## Formats supportés

Ne sont supportés à ce moment que le format `markdown` en entrée et les formats `html` et `pdf` en sortie.

## Utilisation

Vous pouvez exécuter les scripts sur une installation locale de Pandoc ou dans un conteneur.

### Installation de Pandoc locale

```bash
./pandoc.sh pdf ceai test/test.md ./test3.pdf
```

### Conteneur


```bash
./pandoc-container.sh pdf ceai test/test.md ./test3.pdf
```

## Création de thème

TODO

## Références

[Manuel Pandoc](https://pandoc.org/MANUAL.html)
