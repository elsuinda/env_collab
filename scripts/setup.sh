#!/bin/bash

# Función para verificar si un comando está disponible
check_command() {
  command -v "$1" >/dev/null 2>&1
}

# Verificar e instalar Docker
if ! check_command docker; then
  echo "Docker no está instalado. ¿Desea instalarlo? (s/n)"
  read -r install_docker
  if [ "$install_docker" = "s" ]; then
    echo "Instalando Docker..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker instalado correctamente."
  else
    echo "Docker es necesario para continuar. Abortando."
    exit 1
  fi
else
  echo "Docker ya está instalado."
fi

# Verificar e instalar Docker Compose
if ! check_command docker-compose; then
  echo "Docker Compose no está instalado. ¿Desea instalarlo? (s/n)"
  read -r install_compose
  if [ "$install_compose" = "s" ]; then
    echo "Instalando Docker Compose..."
    sudo apt update
    sudo apt install -y docker-compose
    echo "Docker Compose instalado correctamente."
  else
    echo "Docker Compose es necesario para continuar. Abortando."
    exit 1
  fi
else
  echo "Docker Compose ya está instalado."
fi

# Verificar e instalar otras herramientas necesarias
if ! check_command curl; then
  echo "curl no está instalado. ¿Desea instalarlo? (s/n)"
  read -r install_curl
  if [ "$install_curl" = "s" ]; then
    echo "Instalando curl..."
    sudo apt update
    sudo apt install -y curl
    echo "curl instalado correctamente."
  else
    echo "curl es necesario para continuar. Abortando."
    exit 1
  fi
else
  echo "curl ya está instalado."
fi

# Verificar permisos de Docker
if ! groups | grep -q "\bdocker\b"; then
  echo "El usuario actual no pertenece al grupo 'docker'. ¿Desea añadirlo? (s/n)"
  read -r add_to_docker_group
  if [ "$add_to_docker_group" = "s" ]; then
    sudo usermod -aG docker "$USER"
    echo "Usuario añadido al grupo 'docker'. Por favor, cierre sesión y vuelva a iniciarla para aplicar los cambios."
  else
    echo "Sin permisos de Docker, deberá usar 'sudo' para ejecutar comandos de Docker."
  fi
fi

echo "Todas las herramientas necesarias están instaladas y configuradas."
