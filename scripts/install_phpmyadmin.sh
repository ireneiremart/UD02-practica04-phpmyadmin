#!/bin/bash
# UD02 - Practica 04: phpMyAdmin
# Autora: Irene Pastor Altur
# Instalacion y securizacion de phpMyAdmin

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Comprobar privilegios
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Ejecuta con sudo."
    exit 1
fi

# Cargar variables
if [ ! -f "$SCRIPT_DIR/.env" ]; then
    echo "ERROR: No existe scripts/.env"
    exit 1
fi

source "$SCRIPT_DIR/.env"

echo "======================================"
echo " INSTALACION DE PHPMYADMIN"
echo "======================================"

# Comprobar paquetes
instalar_paquete() {
    local paquete="$1"

    if dpkg-query -W -f='${Status}' "$paquete" 2>/dev/null | grep -qx "install ok installed"; then
        echo "[OK] $paquete instalado."
    else
        apt-get install -y "$paquete"
    fi
}

apt-get update

instalar_paquete phpmyadmin
instalar_paquete php-mbstring
instalar_paquete php-zip
instalar_paquete php-gd
instalar_paquete php-curl
instalar_paquete php-mysql
instalar_paquete apache2-utils

# Comprobar directorio
if [ ! -f "$PHPMYADMIN_PATH/index.php" ]; then
    echo "ERROR: No se encuentra phpMyAdmin."
    exit 1
fi

# Comprobar PHP-FPM
PHP_SOCKET="/run/php/php${PHP_VERSION}-fpm.sock"

if [ ! -S "$PHP_SOCKET" ]; then
    echo "ERROR: No existe $PHP_SOCKET"
    exit 1
fi

# Preparar archivo de autenticacion
if [ ! -f "$HTPASSWD_FILE" ]; then
    echo "Creando credenciales de acceso Nginx..."
    htpasswd -c "$HTPASSWD_FILE" "$HTPASSWD_USER"
else
    echo "[OK] Archivo htpasswd existente."
    if ! cut -d: -f1 "$HTPASSWD_FILE" | grep -Fxq "$HTPASSWD_USER"; then
        htpasswd "$HTPASSWD_FILE" "$HTPASSWD_USER"
    fi
fi

chmod 640 "$HTPASSWD_FILE"
chown root:www-data "$HTPASSWD_FILE"

# Preparar configuracion independiente
NGINX_SITE="/etc/nginx/sites-available/site_phpmyadmin"
NGINX_ENABLED="/etc/nginx/sites-enabled/site_phpmyadmin"

if [ -e "$NGINX_SITE" ] || [ -L "$NGINX_ENABLED" ]; then
    echo "Ya existe una configuracion site_phpmyadmin."
    echo "No se sobrescribira."
    exit 1
fi

# No duplicar la ruta en otra configuracion
if grep -RqiE 'location[[:space:]]+/phpmyadmin' \
    /etc/nginx/sites-enabled/; then
    echo "AVISO: Ya existe una ruta phpMyAdmin habilitada."
    echo "Revisa las configuraciones antes de continuar."
    exit 1
fi

# Generar configuracion
cat > "$NGINX_SITE" <<EOF
server {
    listen ${WEB_PORT};
    server_name ${SERVER_NAME};

    root /usr/share;
    index index.php;

    location = ${PHPMYADMIN_URL} {
        return 301 ${PHPMYADMIN_URL}/;
    }

    location ^~ ${PHPMYADMIN_URL}/ {
        auth_basic "Acceso restringido a phpMyAdmin";
        auth_basic_user_file ${HTPASSWD_FILE};

        alias ${PHPMYADMIN_PATH}/;
        index index.php;

        location ~ \.php$ {
            try_files \$request_filename =404;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME \$request_filename;
            fastcgi_pass unix:${PHP_SOCKET};
        }

        location ~ /(\.|libraries/|templates/|setup/) {
            deny all;
        }
    }
}
EOF

ln -s "$NGINX_SITE" "$NGINX_ENABLED"

# Validar antes de aplicar
if nginx -t; then
    systemctl reload nginx
    echo "[OK] Configuracion de Nginx aplicada."
else
    echo "ERROR: Configuracion de Nginx invalida."
    rm -f "$NGINX_ENABLED"
    echo "Revisa $NGINX_SITE"
    exit 1
fi

echo ""
echo "======================================"
echo " PHPMYADMIN CONFIGURADO"
echo "======================================"
echo "URL: http://${SERVER_NAME}${PHPMYADMIN_URL}/"
echo "Usuario de proteccion: ${HTPASSWD_USER}"
echo "Instalacion terminada."
