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