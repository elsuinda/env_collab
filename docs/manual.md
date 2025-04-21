# Manual de Configuración del Entorno

## Configuración de Nextcloud
Se han realizado los siguientes ajustes en el contenedor de Nextcloud:
- **ONLYOFFICE_URL**: Define la URL del servidor de OnlyOffice para integrarlo con Nextcloud.
- **NEXTCLOUD_TRUSTED_DOMAINS**: Lista de dominios confiables para evitar advertencias de seguridad.
- **NEXTCLOUD_ADMIN_USER y NEXTCLOUD_ADMIN_PASSWORD**: Credenciales del administrador inicial de Nextcloud.
- **NEXTCLOUD_DB_TYPE, NEXTCLOUD_DB_HOST, NEXTCLOUD_DB_NAME, NEXTCLOUD_DB_USER, NEXTCLOUD_DB_PASSWORD**: Configuración para usar PostgreSQL como base de datos en lugar de SQLite.

### Migración de SQLite a PostgreSQL
Para migrar la base de datos de SQLite a PostgreSQL, sigue estos pasos:
1. Asegúrate de que los contenedores estén en ejecución.
2. Ejecuta el siguiente comando dentro del contenedor de Nextcloud:
   ```bash
   docker exec -it <nextcloud_container_id> occ db:convert-type --all-apps pgsql nextcloud db nextcloudpassword
   ```
   Reemplaza `<nextcloud_container_id>` con el ID del contenedor de Nextcloud.

## Configuración de OnlyOffice
Se han añadido las siguientes variables de entorno:
- **JWT_ENABLED**: Habilita la autenticación mediante tokens JWT.
- **JWT_SECRET**: Define la clave secreta para los tokens JWT.
- **NEXTCLOUD_URL**: URL del servidor de Nextcloud para integrarlo con OnlyOffice.

## Configuración de PostgreSQL
El contenedor de PostgreSQL se ha configurado con las siguientes variables:
- **POSTGRES_USER**: Usuario de la base de datos para Nextcloud.
- **POSTGRES_PASSWORD**: Contraseña del usuario de la base de datos.
- **POSTGRES_DB**: Nombre de la base de datos utilizada por Nextcloud.

## Configuración de HTTPS
Se recomienda configurar un proxy inverso (como Nginx o Traefik) para habilitar HTTPS. Esto mejora la seguridad y permite el uso de funciones avanzadas como "service workers". Puedes usar Let's Encrypt para generar certificados SSL gratuitos.

### Reinicio de Contenedores
Después de realizar cambios en el archivo `docker-compose.yml`, reinicia los contenedores con:
```bash
docker-compose down && docker-compose up -d
```

### Notas Adicionales
- Asegúrate de que las rutas de los volúmenes sean correctas y tengan los permisos necesarios.
- Verifica que los contenedores puedan comunicarse entre sí mediante sus nombres de servicio definidos en `docker-compose.yml`.
