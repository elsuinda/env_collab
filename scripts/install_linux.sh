#!/bin/bash
# Colores
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}"
cat << "EOF"
  ╔════════════════════════════════════════════╗
  ║          INSTALADOR ENV_COLLAB             ║
  ╚════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar dependencias
if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado. Por favor, instálalo antes de continuar."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose no está instalado. Por favor, instálalo antes de continuar."
    exit 1
fi

echo "¿Deseas usar la interfaz gráfica para la instalación? (s/n)"
read -r use_gui

if [[ "$use_gui" == "s" || "$use_gui" == "S" ]]; then
    # Lanzar GUI
    python3 scripts/gui_installer.py
    exit 0
fi

# Continuar con la instalación en modo texto
echo "Iniciando instalación en modo texto..."

# Iniciar servicios
echo -e "${GREEN}[+] Iniciando contenedores...${NC}"
docker-compose up -d

# Mensaje final
echo -e "${GREEN}"
cat << "EOF"
  ╔════════════════════════════════════════════╗
  ║       ¡INSTALACIÓN COMPLETADA!             ║
  ║                                            ║
  ║  Accede a Nextcloud en: http://localhost:8080  ║
  ║  OnlyOffice en: http://localhost:9000      ║
  ╚════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo "Instalación completada. ¡Disfruta usando env_collab! 🚀"