#!/bin/bash

# THIS SCRIPT ONLY WORKS WITH FIREWALLD

add_firewall_rule() {
    firewall-cmd --permanent --zone="$1" --add-rich-rule="rule family=\"$2\" source address=\"$3\" port protocol=\"$4\" port=\"$5\" accept"
}

# Get ports protocol logic
get_protocol_name() {
    if [[ "$1" == "1" ]]; then
        echo "tcp"
    elif [[ "$1" == "2" ]]; then
        echo "udp"
    else
        echo "Invalid protocol selection."
        exit 1
    fi
}

echo "Select IP address family:"
echo "[1]: IPv4"
echo "[2]: IPv6"
read -r -n 1 ip_family

if [[ "$ip_family" != "1" && "$ip_family" != "2" ]]; then
    echo "Invalid selection. Exiting."
    exit 1
fi

if [[ "$ip_family" == "1" ]]; then
    ip_family="ipv4"
elif [[ "$ip_family" == "2" ]]; then
    ip_family="ipv6"
fi

echo "Select protocol:"
echo "[1]: TCP"
echo "[2]: UDP"
read -r -n 1 protocol_num

protocol=$(get_protocol_name "$protocol_num")

echo "Insert IP addresses with subnets (e.g., 192.168.1.0/24 10.0.0.0/16):"
read -r ips

echo "Insert port:"
read -r port

echo "Insert firewall zone:"
read -r zone

# Split IPs with subnets by space and loop through each other if it exists
IFS=' ' read -r -a ip_subnets <<< "$ips"
for ip_subnet in "${ip_subnets[@]}"; do
    add_firewall_rule "$zone" "$ip_family" "$ip_subnet" "$protocol" "$port"
done

# Reload firewall to apply changes
firewall-cmd --reload

echo "Firewall rules added successfully."
