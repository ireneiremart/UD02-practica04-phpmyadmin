#!/bin/bash
# UD02 - Practica 04: phpMyAdmin
# Autora: Irene Pastor Altur
# Instalacion automatizada de LEMP

set -euo pipefail

# Localizar directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cargar variables
if [ ! -f "$SCRIPT_DIR/.env" ]; then
    echo "ERROR: No existe el archivo .env"
    exit 1
fi

source "$SCRIPT_DIR/.env"

# Comprobar permisos de administrador
if [ "$EUID" -ne 0 ]; then
    echo "Ejecuta este script con sudo."
    exit 1
fi

# Instalar paquetes solo cuando faltan
instalar_paquete() {
    local paquete="$1"

    if dpkg-query -W -f='${Status}' "$paquete" 2>/dev/null | grep -qx "install ok installed"; then
        echo "[OK] $paquete ya esta instalado."
    else
        echo "[INSTALANDO] $paquete"
        apt-get install -y "$paquete"
    fi
}

echo "======================================"
echo " INSTALACION AUTOMATICA DE LEMP"
echo "======================================"

# Actualizar paquetes disponibles
apt-get update

# Servidor web
instalar_paquete nginx

# Base de datos
if [ "$DB_SERVER" = "mariadb" ]; then
    instalar_paquete mariadb-server
else
    instalar_paquete mysql-server
fi

# PHP y extensiones necesarias
instalar_paquete php-fpm
instalar_paquete php-cli
instalar_paquete php-mysql
instalar_paquete php-mbstring
instalar_paquete php-zip
instalar_paquete php-gd
instalar_paquete php-curl
instalar_paquete php-xml

# Activar servicios
systemctl enable --now nginx

if [ "$DB_SERVER" = "mariadb" ]; then
    systemctl enable --now mariadb
else
    systemctl enable --now mysql
fi

# Comprobar servicios
echo ""
echo "======================================"
echo " VERIFICACION DE SERVICIOS"
echo "======================================"

systemctl is-active nginx
systemctl is-active "$DB_SERVER"

php -v | head -n 1

echo ""
echo "[OK] Instalacion LEMP finalizada."
