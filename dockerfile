# Utiliza una imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los repositorios e instala dependencias si es necesario
RUN apt-get update && apt-get install -y mysql-client
WORKDIR /liberty
COPY / /liberty


# Define un punto de entrada predeterminado (opcional)
CMD ["sleep", "infinity"]