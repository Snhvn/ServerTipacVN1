# Use Ubuntu 24.04 LTS as base image
FROM ubuntu:24.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Define admin user environment variables

# Install required packages and PufferPanel
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    systemctl \
    sudo \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install PufferPanel repository and package
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh?any=true | bash && \
    apt-get update && \
    apt-get install -y pufferpanel

# Create entrypoint script
RUN cat <<EOF > /start.sh
echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel
pufferpanel user add --admin --email "admin@dsc.gg/servertipacvn" --name "Admin" --password "Admin123"
echo "Starting PufferPanel service..."
systemctl restart pufferpanel 

EOF 

RUN chmod +x /start.sh

# Expose PufferPanel web interface port
EXPOSE 8080 5657

# Set entrypoint
CMD bash /start.sh
