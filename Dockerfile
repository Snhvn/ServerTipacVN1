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

EOF

RUN chmod +x /start.sh

CMD python3 -m http.server 8080 & \
    bash /start.sh
