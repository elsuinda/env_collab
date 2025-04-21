# 🐧 Instalación en Linux

¡Sigue estos pasos para instalar **env_collab** en tu sistema Linux! 🚀

## 📋 Requisitos
- 🐋 **Docker** y **Docker Compose** instalados.
- 💾 **4 GB de RAM mínimo**.
- 👤 Usuario con permisos para ejecutar Docker.

## 🛠️ Pasos de instalación
1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/env_collab.git
   cd env_collab
   ```

2. **Da permisos de ejecución a los scripts**:
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Ejecuta el script de instalación**:
   ```bash
   bash scripts/install_linux.sh
   ```
   - Durante la instalación, se te preguntará si deseas usar la interfaz gráfica (GUI). 🌟

4. **Verifica que los servicios estén corriendo**:
   - 🌐 Nextcloud: [http://localhost:8080](http://localhost:8080)
   - 🌐 OnlyOffice: [http://localhost:9000](http://localhost:9000)

5. **(Opcional) Verifica los contenedores**:
   ```bash
   docker ps
   ```

6. **Para detener los servicios**:
   ```bash
   docker-compose down
   ```

## 🛠️ Configuración de la red de Docker

1. **Crea una red personalizada para los contenedores**:
   - Esto permite que los contenedores se comuniquen entre sí usando sus nombres de servicio.
     ```bash
     docker network create env_collab_network
     ```

2. **Verifica que la red se haya creado correctamente**:
   ```bash
   docker network ls
   ```

3. **Conecta los contenedores a la red personalizada**:
   - Asegúrate de que en el archivo `docker-compose.yml` los servicios estén configurados para usar la red `env_collab_network`:
     ```yaml
     networks:
       default:
         name: env_collab_network
     ```

## 🗄️ Configuración de PostgreSQL

1. **Configura PostgreSQL en el archivo `docker-compose.yml`**:
   - Asegúrate de que el servicio de PostgreSQL esté definido correctamente:
     ```yaml
     services:
       postgres:
         image: postgres:latest
         container_name: postgres
         environment:
           POSTGRES_USER: your_user
           POSTGRES_PASSWORD: your_password
           POSTGRES_DB: your_database
         networks:
           - default
         volumes:
           - postgres_data:/var/lib/postgresql/data
     volumes:
       postgres_data:
     ```

2. **Verifica la conectividad con PostgreSQL**:
   - Desde otro contenedor, prueba la conexión:
     ```bash
     docker exec -it <nombre_del_contenedor> psql -h postgres -U your_user -d your_database
     ```

3. **Configura los servicios para usar PostgreSQL**:
   - Asegúrate de que los servicios como Nextcloud estén configurados para conectarse a PostgreSQL usando el nombre del contenedor como host (`postgres`).

## 🔄 Verificación de conectividad entre contenedores

1. **Prueba la conectividad entre los contenedores**:
   - Usa el comando `ping` para verificar que los contenedores pueden comunicarse:
     ```bash
     docker exec -it <nombre_del_contenedor_1> ping <nombre_del_contenedor_2>
     ```

2. **Verifica que los servicios estén funcionando**:
   - Accede a las URLs de los servicios (por ejemplo, Nextcloud y OnlyOffice) y asegúrate de que estén operativos.

## 🔄 Backups automáticos

1. **Configuración predeterminada**:
   - El sistema realiza un backup automático de los datos a las **03:00 a.m. (UTC-3, hora de Argentina)**.
   - Los archivos de backup se almacenan en la carpeta `backups` dentro del proyecto.

2. **Cambiar la hora del backup**:
   - Accede al contenedor encargado de los backups:
     ```bash
     docker exec -it <nombre_del_contenedor_backup> sh
     ```
   - Edita el cron job que controla los backups:
     ```bash
     crontab -e
     ```
   - Cambia la hora según sea necesario. Por ejemplo, para realizar el backup a las 02:00 a.m.:
     ```cron
     0 2 * * * /ruta/al/script_de_backup.sh
     ```
   - Guarda los cambios y verifica que el cron job esté activo:
     ```bash
     crontab -l
     ```

3. **Verificar los backups**:
   - Asegúrate de que los archivos de backup se estén generando correctamente en la carpeta `backups`.

## 📦 Redimensionar volúmenes de manera segura

1. **Detén los contenedores**:
   - Antes de redimensionar los volúmenes, detén todos los contenedores para evitar pérdida de datos:
     ```bash
     docker-compose down
     ```

2. **Realiza un backup de los datos actuales**:
   - Copia los datos del volumen a una ubicación segura:
     ```bash
     docker run --rm -v <nombre_del_volumen>:/data -v $(pwd):/backup busybox tar czf /backup/backup.tar.gz /data
     ```

3. **Elimina el volumen existente**:
   - Si necesitas redimensionar el volumen, primero elimínalo (asegúrate de tener un backup):
     ```bash
     docker volume rm <nombre_del_volumen>
     ```

4. **Crea un nuevo volumen con mayor capacidad**:
   - Crea un volumen nuevo con las opciones necesarias:
     ```bash
     docker volume create --name <nombre_del_volumen> --opt size=<nuevo_tamaño>
     ```

5. **Restaura los datos al nuevo volumen**:
   - Restaura los datos desde el backup:
     ```bash
     docker run --rm -v <nombre_del_volumen>:/data -v $(pwd):/backup busybox tar xzf /backup/backup.tar.gz -C /data
     ```

6. **Reinicia los contenedores**:
   - Una vez que los datos estén restaurados, reinicia los contenedores:
     ```bash
     docker-compose up -d
     ```

7. **Verifica que los datos estén intactos**:
   - Asegúrate de que los servicios funcionen correctamente y que los datos estén disponibles.

## 📝 Notas adicionales
- Los volúmenes de los contenedores son persistentes, lo que significa que los datos no se perderán al reiniciar los contenedores.
- Asegúrate de realizar backups regulares antes de realizar cambios importantes en los volúmenes o configuraciones.

## 📝 Notas
- Si encuentras problemas con permisos, asegúrate de que tu usuario esté en el grupo `docker` o ejecuta los comandos con `sudo`.
- Asegúrate de que las carpetas de configuración (`configs/nextcloud_config` y `configs/onlyoffice_config`) existan y tengan los permisos adecuados.
- La GUI del instalador incluye una barra de progreso animada, un botón para abortar la instalación y descripciones breves del trabajo en curso. 🎨

---

## 💖 ¡Apoya este proyecto!
Si te gustó este proyecto y deseas apoyarlo, considera hacer una donación. ¡Cualquier aporte es bienvenido! 🙌

💸 **Donaciones**:
- Metamask: `0x72A4DD1055a11960EbF768Ea53E6e2CF20F89f83`
- UALÁ USD: `3840200500000033089766`
- UALÁ ARS: `3840200500000005543881`

---

**by ElSuinda @v@**