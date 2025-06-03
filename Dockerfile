FROM debian:12


RUN apt update && apt install -y sudo wget curl neofetch systemctl python3-pip && \
    apt clean

RUN cat <<EOF > /start.sh
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py && chmod -R 777 /bin/systemctl
apt install pufferpanel
sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:8080\"/g" /etc/pufferpanel/config.json
pufferpanel user add --name "Admin" --password "Admin123" --email "admin@dsc.gg/servertipacvn" --admin
systemctl restart pufferpanel
echo "Successfully ✔️"
echo "PUFFERPANEL LOGIN INFO"
echo "👤 Username: Admin"
echo "✉️ Mail: admin@dsc.gg/servertipacvn"
echo "🔑 Password: Admin123"
echo "Subscribe Channel By SNIPA VN https://youtube.com/@snipavn205"
echo "Supported Render & Railway"
sudo mkdir -p --mode=0755 /usr/share/keyrings && \
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | sudo tee /etc/apt/sources.list.d/cloudflared.list && sudo apt-get update && sudo apt-get install cloudflared
cloudflared tunnel --url http://0.0.0.0:8080

EOF

RUN chmod +x /start.sh

CMD bash /start.sh
