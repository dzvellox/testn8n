# Choisissez la version d'Odoo souhaitée. Remplacez 17.0 si nécessaire.
FROM odoo:17.0

# Installer les dépendances du système (si vos modules en ont besoin, par ex. pour les images ou PDF)
# Les dépendances courantes sont 'libpq-dev', 'libxml2-dev', 'libjpeg-dev', 'liblcms2-dev', 'libwebp-dev', 'libz-dev'.
# Si vous n'avez pas besoin de dépendances spécifiques, vous pouvez commenter ou supprimer ce bloc.
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libpq-dev \
        && rm -rf /var/lib/apt/lists/*
USER odoo

# Copier les modules Python additionnels (si non inclus dans les modules Odoo)
# Si vous avez un fichier requirements.txt, décommentez la ligne ci-dessous :
# COPY requirements.txt /tmp/requirements.txt
# RUN pip install -r /tmp/requirements.txt

# Créer le dossier où Odoo va chercher vos modules personnalisés
# Le chemin /mnt/extra-addons est le chemin standard attendu par l'image officielle.
RUN mkdir -p /mnt/extra-addons

# Copier vos modules personnalisés dans l'image
# Le dossier 'custom_addons' doit exister à la racine de votre dépôt Git.
COPY ./custom_addons/ /mnt/extra-addons/

# L'image Odoo par défaut utilise déjà l'utilisateur 'odoo' et exécute la commande de démarrage Odoo.
# Aucune commande CMD/ENTRYPOINT supplémentaire n'est nécessaire ici.
