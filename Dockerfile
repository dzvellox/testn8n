# 1. Base Image
# Nous utilisons l'image officielle Odoo, par exemple la version 17.0.
FROM odoo:17.0

# 2. Variables d'environnement (Optionnel, mais utile pour la clarté)
# Définir l'utilisateur sur 'root' pour les installations système
USER root

# 3. Installation des Dépendances Système (libpq-dev est essentiel pour la DB)
# Nous combinons les commandes pour garantir la robustesse et réduire la taille de l'image.
# Nous ajoutons l'option -y pour l'installation non interactive.
# L'option "--no-install-recommends" maintient l'image légère.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 4. Installation de wkhtmltopdf (Pour les rapports PDF)
# L'image Odoo officielle inclut souvent déjà wkhtmltopdf, mais si ce n'est pas le cas, 
# vous pouvez ajouter ici les étapes manuelles pour le télécharger.
# Pour le moment, nous faisons confiance à l'image Odoo:17.0 qui devrait l'inclure.
# Si l'impression PDF ne fonctionne pas, cette section devra être complétée.

# 5. Retour à l'utilisateur Odoo (Sécurité)
# Toutes les commandes futures s'exécuteront sous l'utilisateur non privilégié 'odoo'.
USER odoo

# 6. Configuration du Lancement (Déjà intégrée)
# La commande d'exécution par défaut (CMD) de l'image 'odoo:17.0' est déjà configurée pour
# lancer le serveur Odoo en utilisant les variables d'environnement. 
# Aucune CMD ou ENTRYPOINT supplémentaire n'est nécessaire ici.

# Le conteneur écoutera par défaut sur le port 8069.

# FIN DU DOCKERFILE
