# Utiliser l'image de base Ubuntu Jammy
FROM ubuntu:jammy

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
    && rm -rf /var/lib/apt/lists/*  # Nettoyer les fichiers temporaires

# Définir le répertoire de travail
WORKDIR /Vanadiel_XI

# Cloner le dépôt avec les sous-modules
RUN git clone --recursive https://github.com/AlexandreCA/Vanadiel_XI.git

# Installer les dépendances Python
WORKDIR /Vanadiel_XI
RUN pip3 install -r Vanadiel_XI/tools/requirements.txt

# Copier les fichiers de configuration par défaut
RUN cp Vanadiel_XI/settings/default/* Vanadiel_XI/settings/

# Créer le répertoire de build
RUN mkdir build

# Changer de répertoire et compiler le projet
WORKDIR Vanadiel_XI/build
RUN cmake .. && make -j$(nproc)

# Exposer le port 80 (ou un autre si nécessaire)
EXPOSE 80

# Commande à exécuter lorsque le conteneur démarre
CMD ["bash"]
