echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel
pufferpanel user add --admin --email "admin@dsc.gg/servertipacvn" --name "Admin" --password "Admin123"
echo "Starting PufferPanel service..."
systemctl restart pufferpanel
