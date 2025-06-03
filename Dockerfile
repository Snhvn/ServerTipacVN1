# Use Ubuntu 24.04 LTS as base image
FROM ubuntu:24.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Define admin user environment variables
ENV ADMIN_EMAIL="admin@servertipacvn"
ENV ADMIN_NAME="Admin"
ENV ADMIN_PASSWORD="Admin123"

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
#!/bin/bash

# Start PufferPanel service
echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel

# Check if this is first time startup
FIRST_START_FLAG="/var/lib/pufferpanel/.first_start"
if [ ! -f "$FIRST_START_FLAG" ]; then
    echo "First time startup detected - creating admin user..."
    
    # Check if all required environment variables are set
    if [ -z "$ADMIN_EMAIL" ] || [ -z "$ADMIN_NAME" ] || [ -z "$ADMIN_PASSWORD" ]; then
        echo "Error: Please set ADMIN_EMAIL, ADMIN_NAME, and ADMIN_PASSWORD environment variables"
        exit 1
    fi

    # Create admin user
    pufferpanel user add --admin --email "$ADMIN_EMAIL" --name "$ADMIN_NAME" --password "$ADMIN_PASSWORD"
    
    # Create flag file to indicate first start is complete
    touch "$FIRST_START_FLAG"
fi

# Start PufferPanel
echo "Starting PufferPanel service..."
systemctl start pufferpanel

# Keep container running
echo "Container is running. Press Ctrl+C to stop."
tail -f /dev/null 

EOF 

RUN chmod +x /start.sh

# Expose PufferPanel web interface port
EXPOSE 8080 5657

# Set entrypoint
CMD bash /start.sh
