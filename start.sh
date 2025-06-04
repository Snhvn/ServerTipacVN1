echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel
pufferpanel user add --admin --email "admin@servertipacvn.com" --name "Admin" --password "dsc.gg/servertipacvn"
echo "Starting PufferPanel service..."
sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:8080\"/g" /etc/pufferpanel/config.json
systemctl restart pufferpanel
