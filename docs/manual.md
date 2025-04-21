# Manual de Configuración del Entorno

## Instalación Automática
El entorno se configura automáticamente utilizando el script `install.sh`. Este script inicia los contenedores y configura Nextcloud y OnlyOffice.

### Pasos para la instalación
1. Asegúrate de que Docker y Docker Compose estén instalados.
2. Ejecuta el script de instalación:
   ```bash
   ./scripts/install.sh
   ```
3. Al finalizar, el script mostrará los detalles de la instalación, incluyendo:
   - URL de Nextcloud y OnlyOffice.
   - Credenciales de administrador de Nextcloud.
   - Clave secreta (`JWT_SECRET`) para OnlyOffice.
4. Los detalles también se guardarán en el archivo `installation_details.txt` ubicado en la carpeta `scripts`.

### Acceso a las plataformas
- **Nextcloud**:
  - URL: `http://localhost:8080`
  - Usuario: `admin`
  - Contraseña: `adminpassword`
- **OnlyOffice**:
  - URL: `http://localhost:9000`
  - JWT_SECRET: `mysecret`

### Solución de Problemas
Si encuentras problemas durante la instalación:
1. Verifica que Docker y Docker Compose estén instalados correctamente.
2. Revisa los registros de los contenedores:
   ```bash
   docker-compose logs
   ```
3. Asegúrate de que los puertos 8080 y 9000 no estén en uso por otros servicios.

### Configuración de HTTPS
Se recomienda configurar un proxy inverso (como Nginx o Traefik) para habilitar HTTPS. Puedes usar Let's Encrypt para generar certificados SSL gratuitos.

### Reinicio de Contenedores
Si necesitas reiniciar los contenedores, ejecuta:
```bash
docker-compose down && docker-compose up -d
```

### Notas Adicionales
- Asegúrate de que las rutas de los volúmenes sean correctas y tengan los permisos necesarios.
- Verifica que los contenedores puedan comunicarse entre sí mediante la red `collab_network`.
