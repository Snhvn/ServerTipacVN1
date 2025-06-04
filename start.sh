echo "Starting PufferPanel service..."
systemctl enable --now pufferpanel
pufferpanel user add --admin --email "admin@servertipacvn.com" --name "Admin" --password "dsc.gg/servertipacvn"
echo "Starting PufferPanel service..."
sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:8080\"/g" /etc/pufferpanel/config.json
systemctl restart pufferpanel
sudo mkdir -p --mode=0755 /usr/share/keyrings && \
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | sudo tee /etc/apt/sources.list.d/cloudflared.list && sudo apt-get update && sudo apt-get install cloudflared
cloudflared tunnel --url http://0.0.0.0:8080
