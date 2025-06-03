# Imagen base de Linux
FROM debian:bullseye-slim

# Establecer variables de entorno para evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear volúmenes para configuración y datos
RUN mkdir -p /volumes/config /volumes/data

# Descargar y configurar PufferPanel
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh && \
    docker volume create pufferpanel-config && \
    docker volume create pufferpanel-data && \
    docker run -d --name pufferpanel \
      -p 8080:8080 \
      -p 5657:5657 \
      -v pufferpanel-config:/etc/pufferpanel \
      -v pufferpanel-data:/var/lib/pufferpanel \
      --restart=on-failure \
      pufferpanel/pufferpanel:latest && \
    sleep 10

# Añadir credenciales de usuario preconfiguradas
# (Reemplaza los valores USERNAME y PASSWORD con tus credenciales reales)
RUN docker exec -it pufferpanel /pufferpanel/pufferpanel user add --name Admin \
    --email admin@dsc.gg/servertipacvn --password Admin123

# Exponer los puertos necesarios para el acceso a PufferPanel
EXPOSE 8080 5657

# Configurar punto de entrada
CMD ["docker", "start", "pufferpanel", "-ai"]
