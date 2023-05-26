# Instalación de Node.js, Node-RED y PM2 offline en Phoenix Contact WP-6000
- [Node.js](https://nodejs.org/es/).
- [Node-RED](https://nodered.org/).
- [PM2](http://pm2.keymetrics.io/).

A continuación veremos como instalar Node.js, Node-RED y PM2 offline en una WP6000. Una vez instalados podrás ejecutar paquetes instalados localmente.
Todas las preparaciones previas, necesarias para la instalación offline de todos los paquetes se llevan a cabo en un host Linux o Windows con acceso a Internet.

## Instalar entorno WSL (Subsistema de Windows para Linux) 
Si no tiene un host con Linux, es posible ejecutar un sistema operativo Linux (por ejemplo, Ubuntu) sobre un host de Windows. Para ello, vamos a utilizar WSL. 
- Ir a [Ubuntu WSL](https://ubuntu.com/wsl) e instalar Ubuntu desde la tienda de aplicaciones de Windows.
- Abrir una terminal de Windows con el comando ```cmd```.
- Ejecutar el comando ```wsl -l -v``` y comprobar que tenemos la distribución Ubuntu instalada con la versión de WSL 2.
- Si la versión de WSL es la 1, se puede modificar ejecutando el comando ```wsl --set-version <distro name> 2``` (donde <distro name> en nuestro caso será Ubuntu).
- Ejecutar el comando ```wsl``` para __entrar en la distribución de Linux instalada__. A partir de aquí, la terminal ejecutará comandos de Linux. Para salir de WSL ejecutar el comando ```exit```.
- Los directorios de nuestro host Windows estarán montados sobre la ruta /mnt/ de la distribución de Linux. Por ejemplo, el directorio ```C:\Users\miusuario\Downloads``` en Windows será ```/mnt/c/Users/miusuario/Downloads``` en la distribución de Linux.
- Comprobar que la distribución de Linux tenga acceso a internet, por ejemplo con ```ping google.com```. Si no es así, revisar la configuración IP y que el fichero ```/etc/resolv.conf``` tenga el siguiente contenido ```nameserver 8.8.8.8```.
  
## Node.js
Cuando se escribió esta guía, la última versión estable de Node.js era la 18.16.0. Para comprobar la última versión de Node.js, visitar la página principal de [Node.js](https://nodejs.org/es/). 
Una vez decidida la versión a instalar, descargarla mediante el siguiente comando (adaptar según la versión):
- Linux: ```curl -LO https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-arm64.tar.gz``` . Si curl no está instalado, se puede instalar con el comando: ```apt-get install curl```
- Windows: ```curl -LO https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-arm64.tar.gz```

## PM2
Al contrario que Node.js, PM2 no puede descargarse como tar.gz. Para instalarlo, es necesario descargar su paquete npm y hacer un tarball nosotros mismos. Para ello, es necesario tener Node.js y npm instalados en nuestro host Linux. Si no estuvieran disponibles en el sistema, ejecutar los siguiente comandos en nuestro host Linux:
- ```apt install nodejs```
- ```apt install npm```
Una vez instalados Node.js y npm, ejecutar el comando:
- ```npm install -g npm-bundle```
Esto instala el paquete "npm-bundle" globalmente. El paquete "npm-bundle" nos permitirá crear un tarball de PM2 y todas sus dependencias una vez que lo hayamos descargado.
Cuando el paquete haya sido instalado globalmente, necesitamos descargar PM2 en una carpeta local de nuestro host Linux. Para ello, ejecutar los comandos:
- ```mkdir pm2```
- ```cd pm2```
- ```npm install pm2```
Después de la instalación de PM2 en nuestra carpeta local, hay que empaquetar todo:
- ```npm-bundle pm2```. Esto generará el fichero pm2-5.3.0.tgz (según versión) dentro del directorio pm2 creado anteriormente.

## Copiar los tarballs Node-Red y PM2 del host a la WP6000
1. Conéctese a la WP6000 por __SFTP__ a través de su dirección IP e inicie sesión como usuario browser. La contraseña por defecto para el usuario browser es browser.
2. Copiar los ficheros __node-v18.16.0-linux-arm64.tar.gz__ y __pm2-5.3.0.tgz__ a __/home/browser/__.

## Instalación en WP6000
1. Conectar al dispositivo por __SSH__ como browser. 
2. Cambiar al usuario root. Ejecutar el comando ```su```. La contraseña para root es foo. 
3. Descomprimir los 2 ficheros en la carpeta /opt. Ejecutar los comandos:
  ```mkdir -p /opt```
  ```tar xpf /home/browser/node-v18.16.0-linux-arm64.tar.gz -C /opt```
  ```tar xpf /home/browser/pm2-5.3.0.tgz -C /opt```
4. El paquete PM2 se va a extraer en una carpeta llamada _package_. Para cambiar el nombre, ejecutar el comando:
  ```mv /opt/package /opt/pm2```
5. Ahora que todo está instalado, se pueden eliminar los 2 tarballs:
  ```rm /home/browser/node-v18.16.0-linux-arm64.tar.gz```
  ```rm /home/browser/pm2-5.3.0.tgz```

6. El último paso es añadir las nuevas rutas bin al PATH para que los comandos __PM2, npm y node__ esten disponibles en todo el sistema.
7. Crear y editar un nuevo archivo /etc/profile.d/node.sh
  ```mkdir -p /etc/profile.d```
  ```vim /etc/profile.d/node.sh```
8. Añadir las siguientes líneas en el archivo:
  ```  #!/bin/sh
    export PATH="$PATH:/opt/node-v16.15.1-linux-arm64/bin:/opt/pm2/bin"   ```
  

 
  



