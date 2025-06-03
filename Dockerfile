FROM debian:12


RUN apt install sudo wget curl neofetch systemctl python3-pip -y && apt clean

RUN wget -O /start.sh 

RUN chmod +x /start.sh

CMD bash /start.sh
