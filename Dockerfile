FROM pufferpanel/pufferpanel:latest

RUN pufferpanel user add --name "Admin" --password "Admin123" --email

EXPOSE 8080
CMD ["/pufferpanel/pufferpanel"]
