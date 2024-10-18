# Utiliser l'image de base Ubuntu Jammy
FROM ubuntu:jammy

# Créer un utilisateur non-root et un groupe
RUN useradd -m -s /bin/bash vanadielxi

# Mettre à jour les paquets et installer des dépendances
RUN apt-get update && apt-get install -y \
    git \
    nano \
    python3 \
    python3-pip \
    g++-10 \
    cmake \
    make \
    libluajit-5.1-dev \
    libzmq3-dev \
    libssl-dev \
    zlib1g-dev \
    mariadb-server \
    libmariadb-dev \
    binutils \
    binutils-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*  # Nettoyer les fichiers temporaires

# Définir le répertoire de travail
WORKDIR /Vanadiel_XI

# Cloner le dépôt avec les sous-modules
# Cette étape se fait avec l'utilisateur root, mais il ne pourra pas écrire dans le répertoire du projet par la suite.
RUN git clone --recursive https://github.com/AlexandreCA/Vanadiel_XI.git .

# Changer les permissions pour le répertoire
RUN chown -R vanadielxi:vanadielxi /Vanadiel_XI

# Passer à l'utilisateur non-root
USER vanadielxi

# Copier les fichiers de configuration par défaut
RUN cp settings/default/* settings/

# Installer les dépendances Python
RUN pip3 install -r tools/requirements.txt

# Changer de répertoire et compiler le projet
WORKDIR build
RUN cmake .. && make -j$(nproc)

# Exposer les ports 80 et 54230
EXPOSE 80 54230

# Commande à exécuter lorsque le conteneur démarre
CMD ["bash"]
