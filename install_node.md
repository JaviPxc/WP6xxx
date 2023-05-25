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
- Los directorios de nuestro host Windows estarán montados sobre la ruta /mnt/ de la distribución de Linux. Por ejemplo, el directorio ```C:\Users\miusuario``` en Windows será ```/mnt/c/Users/miusuario``` en la distribución de Linux.

## Node.js
Cuando se escribió esta guía, la última versión estable de Node.js era la 18.16.0. Para comprobar la última versión de Node.js, visitar la página principal de [Node.js](https://nodejs.org/es/). 
Una vez decidida la versión a instalar, descargarla mediante el siguiente comando (adaptar según la versión):
- Linux: ```curl -LO https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-arm64.tar.xz``` . Si curl no está instalado, se puede instalar con el comando: ```apt-get install curl```
- Windows: ```curl -LO https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-arm64.tar.xz```
- Descarga desde la página web : https://nodejs.org/es/download --> Versión Binarios Linux ARMv8 (64 bits)

## PM2
Al contrario que Node.js, PM2 no puede descargarse como tar.gz. Para instalarlo, es necesario descargar su paquete npm y hacer un tarball nosotros mismos. Para ello, es nevcesario tener Node.js y npm instalados en nuestro host (Linux o Windows).
Para empezar, ejecuta el siguiente comando
npm install -g npm-bundle
Esto instala el paquete "npm-bundle" globalmente. El paquete "npm-bundle" nos permitirá crear un tarball de PM2 y todas sus dependencias una vez que lo hayamos descargado.
Cuando el paquete haya sido instalado globalmente, necesitamos descargar PM2 en una carpeta local. Hazlo ejecutando estos comandos
mkdir pm2
cd pm2
npm install pm2
Después de la instalación de PM2 en nuestra carpeta creada, vamos a empaquetar todo:
npm-bundle pm2
El tarball creado se encuentra en tu carpeta PM2.





