# Firewaller
A simple way to mass whitelist incoming traffic from specific ip addresses (Currently only made for FirewallD).

###### Backstory
```I needed a way to mass-whitelist incoming traffic from IPs on a specific port from Cloudflare (https://www.cloudflare.com/ips/), TCPShield (https://tcpshield.com/v4-cf/) and so on and I was to lazy to copy and paste the ips myself.```

***

Requirements
- FirewallD

Installation guide:
1. Install the required packages:

  Debian based systems: `sudo apt update -y && sudo apt upgrade -y && sudo apt install firewalld git -y`
  
  RHEL based systems: `sudo dnf update -y && sudo dnf upgrade -y && sudo dnf install firewalld git -y` 
###### Optional (Depending on your firewall configuration): Allow incoming traffic on ssh via `firewall-cmd --zone=public --permanent --add-port=22/tcp && firewall-cmd --reload`

2. Enable the service and start it: `systemctl enable --now firewalld && systemctl start firewalld`
2. Clone the repository: `git clone https://github.com/VexoDev/firewaller`
3. Go into its directory: `cd firewaller`
4. Run `chmod +X firewalld.sh`
5. Start using script via `./firewalld.sh`
