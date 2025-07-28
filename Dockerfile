# Usa a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instala extensões PHP necessárias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Ativa o módulo rewrite do Apache
RUN a2enmod rewrite

# Instala utilitários
RUN apt-get update && apt-get install -y \
    unzip \
    nano \
    curl \
    git \
    libzip-dev \
    zip \
    && docker-php-ext-install zip

# Copia todos os arquivos do projeto para o container
COPY . /var/www/html

# Define permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Define o diretório de trabalho
WORKDIR /var/www/html