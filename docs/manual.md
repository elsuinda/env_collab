# Manual de Configuración del Entorno

## Configuración de Redes
Para garantizar la comunicación entre los contenedores, se ha configurado una red personalizada llamada `collab_network`. Esta red conecta los servicios `nextcloud`, `onlyoffice` y `db`.

Si experimentas problemas de conectividad, verifica que los contenedores estén en la misma red ejecutando:
```bash
docker network inspect collab_network
```

### Solución de Problemas
#### Error: cURL error 7
Si aparece el error:
```
cURL error 7: Failed to connect to onlyoffice port 80
```
Esto indica que Nextcloud no puede conectarse al servidor OnlyOffice. Para solucionarlo:
1. Asegúrate de que los contenedores estén en la misma red (`collab_network`).
2. Verifica la conectividad desde el contenedor de Nextcloud:
   ```bash
   docker exec -it <nextcloud_container_id> curl http://onlyoffice/healthcheck
   ```
3. Reinicia los contenedores si es necesario:
   ```bash
   docker-compose down && docker-compose up -d
   ```

## Configuración de Nextcloud
Se han realizado los siguientes ajustes en el contenedor de Nextcloud:
- **ONLYOFFICE_URL**: Define la URL del servidor de OnlyOffice para integrarlo con Nextcloud.
- **NEXTCLOUD_TRUSTED_DOMAINS**: Lista de dominios confiables para evitar advertencias de seguridad.
- **NEXTCLOUD_ADMIN_USER y NEXTCLOUD_ADMIN_PASSWORD**: Credenciales del administrador inicial de Nextcloud.
- **NEXTCLOUD_DB_TYPE, NEXTCLOUD_DB_HOST, NEXTCLOUD_DB_NAME, NEXTCLOUD_DB_USER, NEXTCLOUD_DB_PASSWORD**: Configuración para usar PostgreSQL como base de datos en lugar de SQLite.

## Migración de SQLite a PostgreSQL
Para migrar la base de datos de SQLite a PostgreSQL, sigue estos pasos:

1. **Asegúrate de que los contenedores estén en ejecución**:
   - Verifica que los contenedores estén corriendo con:
     ```bash
     docker-compose ps
     ```

2. **Ejecuta el comando de migración**:
   - Ingresa al contenedor de Nextcloud:
     ```bash
     docker exec -it <nextcloud_container_id> bash
     ```
     Reemplaza `<nextcloud_container_id>` con el ID o nombre del contenedor de Nextcloud. Puedes obtenerlo con:
     ```bash
     docker ps
     ```

   - Dentro del contenedor, ejecuta el siguiente comando:
     ```bash
     occ db:convert-type --all-apps pgsql nextcloud db nextcloudpassword
     ```
     Este comando migra la base de datos de SQLite a PostgreSQL.

3. **Verifica la migración**:
   - Asegúrate de que los datos se hayan transferido correctamente y que Nextcloud funcione sin problemas.

4. **Reinicia los contenedores**:
   - Sal del contenedor y reinicia los servicios:
     ```bash
     docker-compose down && docker-compose up -d
     ```

### Notas Adicionales
- Asegúrate de que los valores de usuario, contraseña y host coincidan con los definidos en el archivo `docker-compose.yml`.
- Si encuentras errores durante la migración, revisa los registros del contenedor de Nextcloud para obtener más detalles.

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

## Integración de OnlyOffice con Nextcloud
Para integrar el servidor OnlyOffice con Nextcloud, sigue estos pasos:

1. **Accede a la interfaz de administración de Nextcloud**:
   - Inicia sesión en Nextcloud con las credenciales de administrador.

2. **Instala la aplicación OnlyOffice**:
   - Ve a "Aplicaciones" en el menú de administración.
   - Busca "OnlyOffice" en la lista de aplicaciones disponibles.
   - Haz clic en "Descargar e instalar".

3. **Configura OnlyOffice en Nextcloud**:
   - Ve a "Configuración" en el menú de administración.
   - En la sección "Administración", selecciona "OnlyOffice".
   - En el campo **Dirección del servicio de documentos**, ingresa la URL del servidor OnlyOffice:
     ```
     http://onlyoffice:80
     ```
   - (Opcional) Si configuraste JWT en OnlyOffice, habilita la opción "Habilitar firma JWT" e ingresa el valor de `JWT_SECRET` configurado en el archivo `docker-compose.yml`.

4. **Guarda los cambios**:
   - Haz clic en "Guardar" para aplicar la configuración.

5. **Prueba la integración**:
   - Sube un archivo de texto, hoja de cálculo o presentación a Nextcloud.
   - Ábrelo desde la interfaz web para verificar que se edite correctamente con OnlyOffice.

### Solución de Problemas
- Si aparece un error de conexión, verifica que los contenedores de Nextcloud y OnlyOffice estén en ejecución y que puedan comunicarse entre sí.
- Asegúrate de que la URL configurada en Nextcloud coincida con la definida en el archivo `docker-compose.yml`.

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
