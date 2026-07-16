# Contenedores de Sistema de Gestores de Bases de Datos

![ImagenDocker](./img/Imagen%20Docker.png)

## Imágenes

> Comandos para cada imágen

-Descargar imagen de tutorial de Docker

´´´
docker pull docker/getting-started
´´´
-Descargar imagen de MariaDB

```
docker pull mariadb
```

-Descargar imagen de Postgres

```
docker pull postgres:14.22-trixie
```

-Descargar imagen de SQL

```
docker pull mcr.microsoft.com/mssql/server:2022-latest
```

## Creación de contenedores

´´´docker
docker run -d -p 80:80 **Nombre o Código de la imagen**
´´´

Donde:

- -d datach (background)
- -p (el primer número de puerto no se cambia, el segundo sí)

## Contenedor de tutorial de Docker

´´´
docker run -d -p 80:80 docker/getting-started/latest
docker run -d -p 80:80 d7933
´´´

### Contenedor MariaDB sin Volumen

´´´
docker run -d --name Server-MariadbG1 -p 3343:3306 -e MARIADB_ROOT_PASSWORD=123456 628f228f0fd5

Se debe agregar al final el ID de la imagen, con los primeros 5 digitos es suficiente
´´´

### Contenedor MariaDB con Volumen

´´´
docker volume create v-mariadbG1
docker run -d --name Server-MariadbG1 -p 3343:3306 -e MARIADB_ROOT_PASSWORD=123456 -v v-mariadbG1:/var/lib/mysql 628f228f0fd5
´´´

### Contenedor Postgres con Volumen

´´´
docker volume create v-postgresG1
docker run -d --name Server-PostgresG1 -p 5455:5432 -e POSTGRES_PASSWORD=123456 -v v-postgresG1:/var/lib/postgresql/data eba8ddbdd837
´´´

### Contenedor SQLServer sin Volumen

´´´
docker run -d --name Server-SqlG1 \
-p 1433:1433 \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=SqlSrv_2026_Strong!" \
mcr.microsoft.com/mssql/server:2022-latest
´´´

### Contenedor SQLServer con Volumen

´´´
docker volume create v-sqlserverG1

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" -u 0 -p 1450:1433 --name SQLServerG1 -d -v v-sqlserverg1:/var/opt/mssql/data fc010e5c9554
´´´

## Comandos Docker

| Categoría | Descripción |
| :--- | :--- |
| **docker --version** | _Muestra la versión del Docker_ |
| **docker pull nombre_imagen** | _Descargar imagen de muestra_ [Docker Hub](https://hub.docker.com/)|
| **docker images** | _Muestra las imagenes descargadas_ |
| **docker run** | _Crea un contenedor_ |
| **docker ps** | _Muestra los contenedores en ejecución_ |
| **docker container ls** | _Muestra los contenedores en ejecución_ |
| **docker ps -a** | _Muestra todos los contenedores_ |
| **docker container ls -a** | _Muestra todos los contenedores_ |
| **docker rm nombre_contenedor o ID** | _Borra contenedor que no está en ejecución_ |
| **docker rm -f nombre_contenedor o ID** | _Borra contenedor que está en ejecución_ |
| **docker run** | _Nombra un contenedor_ |
| **docker stop nombre_contenedor o ID** | _Detiene el contenedor_ |
| **docker start nombre_contenedor o ID** | _Inicia el contenedor_ |
| **docker rm -f nombre o ID** | _Elimina contenedor aunque esté en ejecución_ |
| **docker volume ls** | _Mostrar los volumenes que existen en docker_ |








