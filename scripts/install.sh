#!/bin/bash

echo "Iniciando la instalación del entorno..."

# Iniciar los contenedores
docker-compose up -d

# Verificar si los contenedores se iniciaron correctamente
if [ $? -eq 0 ]; then
  echo "Los contenedores se han iniciado correctamente."
else
  echo "Error al iniciar los contenedores. Verifica los registros para más detalles."
  exit 1
fi

# Esperar unos segundos para que los servicios estén listos
echo "Esperando a que los servicios estén listos..."
sleep 10

# Mostrar y guardar los detalles de instalación
INSTALLATION_DETAILS="Detalles de la instalación:
-------------------------------------------------
URL de Nextcloud: http://localhost:8080
Usuario administrador de Nextcloud: admin
Contraseña administrador de Nextcloud: adminpassword

URL de OnlyOffice: http://localhost:9000
JWT_SECRET para OnlyOffice: mysecret
-------------------------------------------------
"

echo "$INSTALLATION_DETAILS"
echo "$INSTALLATION_DETAILS" > installation_details.txt

echo "La instalación se ha completado. Los detalles se han guardado en 'installation_details.txt'."
