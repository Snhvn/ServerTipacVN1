# Use Ubuntu 24.04 LTS as base image
FROM debian:12

# Avoid prompts during package installation

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


RUN wget -O /start.sh 

RUN chmod +x /start.sh

# Expose PufferPanel web interface port
EXPOSE 8080 5657

# Set entrypoint
CMD bash /start.sh
