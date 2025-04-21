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

# Función para verificar dependencias
check_dependencies() {
    local missing_dependencies=()

    # Verificar Docker
    if ! command -v docker &> /dev/null; then
        missing_dependencies+=("docker")
    fi

    # Verificar Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        missing_dependencies+=("docker-compose")
    fi

    # Mostrar dependencias faltantes
    if [ ${#missing_dependencies[@]} -ne 0 ]; then
        echo "Las siguientes dependencias están faltando:"
        for dep in "${missing_dependencies[@]}"; do
            echo "- $dep"
        done

        # Preguntar al usuario si desea instalarlas
        echo "¿Deseas instalarlas automáticamente? (s/n)"
        read -r install_missing

        if [[ "$install_missing" == "s" || "$install_missing" == "S" ]]; then
            install_dependencies "${missing_dependencies[@]}"
        else
            echo "Instalación cancelada. Por favor, instala las dependencias manualmente y vuelve a ejecutar el instalador."
            exit 1
        fi
    else
        echo "Todas las dependencias están instaladas."
    fi
}

# Función para instalar dependencias
install_dependencies() {
    for dep in "$@"; do
        case $dep in
            docker)
                echo "Instalando Docker..."
                sudo apt-get update && sudo apt-get install -y docker.io
                ;;
            docker-compose)
                echo "Instalando Docker Compose..."
                sudo apt-get update && sudo apt-get install -y docker-compose
                ;;
            *)
                echo "No se reconoce cómo instalar $dep automáticamente. Por favor, instálalo manualmente."
                ;;
        esac
    done
}

# Llamar a la función de verificación de dependencias
check_dependencies

echo "¿Deseas usar la interfaz gráfica para la instalación? (s/n)"
read -r use_gui

# Verificar si el archivo GUI existe antes de ejecutarlo
if [[ "$use_gui" == "s" || "$use_gui" == "S" ]]; then
    if [[ -f "scripts/gui_installer.py" ]]; then
        python3 scripts/gui_installer.py
        exit 0
    else
        echo "El archivo scripts/gui_installer.py no existe. Continuando en modo texto..."
    fi
fi

# Verificar que los puertos no estén en uso
if lsof -i:8080 &>/dev/null || lsof -i:9000 &>/dev/null; then
    echo "Error: Los puertos 8080 o 9000 ya están en uso. Libéralos antes de continuar."
    exit 1
fi

# Continuar con la instalación en modo texto
echo "Iniciando instalación en modo texto..."

# Iniciar servicios con manejo de errores
echo -e "${GREEN}[+] Iniciando contenedores...${NC}"
if ! docker-compose up -d; then
    echo "Error: No se pudieron iniciar los contenedores. Verifica el archivo docker-compose.yml."
    exit 1
fi

# Mensaje final
echo -e "${GREEN}"
cat << "EOF"
  ╔════════════════════════════════════════════════╗
  ║       ¡INSTALACIÓN COMPLETADA!                 ║
  ║                                                ║
  ║  Accede a Nextcloud en: http://localhost:8080  ║
  ║  OnlyOffice en: http://localhost:9000          ║
  ╚════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo "Instalación completada. ¡Disfruta usando env_collab! 🚀"