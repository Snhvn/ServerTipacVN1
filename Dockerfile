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
#!/bin/bash

# Start PufferPanel service
echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel

# Check if this is first time startup
FIRST_START_FLAG="/var/lib/pufferpanel/.first_start"
if [ ! -f "$FIRST_START_FLAG" ]; then
    echo "First time startup detected - creating admin user..."
    
    # Check if all required environment variables are set

    # Create admin user
    pufferpanel user add --admin --email "admin@dsc.gg/servertipacvn" --name "Admin" --password "Admin123"
    
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
