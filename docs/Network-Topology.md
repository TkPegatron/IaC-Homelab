# Network Topology

Components:
- Cisco CAT3750G
- 1 8G-RaspberryPi-4B
- 2 4G-RaspberryPi-4B
- Dell Optiplex (KVM-XENIA)
- Custom Gaming Rig (KVM-LEGION)

## Design

**Layer2**: This is a bit of a bizzare setup. I have internet provided by a local broadband company with my modem in bridge mode on an access vlan (id:5), and managment/lan/iot lans on 10, 20, and 30 respectively. Each of these is trunked to the RPI-EDGE-FW.

**Layer3**:

|Subnet|Purpose|
|------|-------|
| 172.22.0.0/25'   | Control Plane Network |
| 172.22.0.128/25' | Wireguard VPN Network |
| 172.22.1.0/25'   | User/BYOD Network |
| 172.22.1.128/25' | IOT Network |

For routing I am utilising BGP to propogate routes from the hypervisors and kubernetes nodes to the edge firewall. If one router goes down, service should not be lost (as long as Im not outside the LAN and relying on the internet anyway).

**Firewall**: I wanted to build one out by hand, in part to practice my network engineering skills as well as learn some linux routing and systems design. I have opted to use one of the 4gig raspi's as an edge firewall. I am utilising NFTables as the configuration frontend for the kernel firewall (netfilter), Wireguard to provide secure remote access, and BIRD as a BGP mesh router peered with each kubernetes node. This firewall also uses a native DHCPd instance to provide DHCP for the network. This is also a PiHole forwarding DNS server running in a container.

**Kubernetes**: The Cilium CNI comes with metallb as it's service loadbalancer and forms a mesh of adjacencies with each node in the cluster by default. I am also assigning it a `/16` subnet to use and abuse as I play with the technology.
