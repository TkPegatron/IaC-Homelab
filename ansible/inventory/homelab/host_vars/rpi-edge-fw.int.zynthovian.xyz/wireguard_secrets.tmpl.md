```yaml
# -- { Wireguard VPN } -- #
wireguard_server:
  private_key: 
  endpoint_address: 
  address: "172.22.0.129/25"
  listen_port: "51820"
  ip_subnets:
    - "172.22.0.0/16"
wireguard_clients:
  - description: 
    private_Key: 
    address: "172.22.0.130/32"
  - description: 
    private_Key: 
    address: "172.22.0.131/32"

```
