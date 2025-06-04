echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel
pufferpanel user add --admin --email "admin@servertipacvn.com" --name "Admin" --password "dsc.gg/servertipacvn"
echo "Starting PufferPanel service..."
systemctl restart pufferpanel
