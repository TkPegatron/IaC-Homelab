sudo podman pod create --name dnsmasq-stack --network host
###
sudo podman run -d \
    --replace \
    --name pihole \
    --cap-add=NET_ADMIN \
    --cap-add=NET_RAW \
    -p "53:53/tcp" \
    -p "53:53/udp" \
    -p "80:80/tcp" \
    -e TZ="America/Detroit" \
    -e PIHOLE_DNS=1.1.1.1,1.2.2.1 \
    -v '/opt/pihole-etc/pihole:/etc/pihole/:Z' \
    -v '/opt/pihole-etc/dnsmasq.d/:/etc/dnsmasq.d/:Z' \
    --restart=unless-stopped pihole/pihole:latest
###
# Change webportal password
### sudo podman exec -it pihole sudo pihole -a -p


- "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
