FROM ubuntu:24.04

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias, Apache 2.4 y configurar repositorio para MySQL 9.7
RUN apt-get update && apt-get install -y \
    apache2 \
    wget \
    gnupg \
    lsb-release \
    && wget https://mysql.com \
    && dpkg -i mysql-apt-config_0.8.32-1_all.deb \
    && apt-get update \
    && apt-get install -y mysql-server \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f mysql-apt-config_0.8.32-1_all.deb

# Exponer los puertos de Apache (80) y MySQL (3306)
EXPOSE 80 3306

# Comando para iniciar ambos servicios (MySQL en segundo plano y Apache en primer plano)
CMD service mysql start && source /etc/apache2/envvars && apache2 -DFOREGROUND

