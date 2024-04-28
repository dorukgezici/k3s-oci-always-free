#!/bin/bash

echo "[user_data.sh] Setting up k3s cluster node: $HOSTNAME"
echo "[user_data.sh] Clearing iptables..."
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F && iptables -X
netfilter-persistent save

echo "[user_data.sh] Installing tailscale for tunneling..."
curl -fsSL https://tailscale.com/install.sh | sh

if [[ "$HOSTNAME" =~ "1-server" ]]; then
    echo "[user_data.sh] Installing k3s server with --cluster-init..."
    curl -sfL https://get.k3s.io | K3S_TOKEN="${cluster_token}" sh -s - server --cluster-init --tls-san="${tls_san}" --vpn-auth="name=tailscale,joinKey=${tailscale_auth_key}" --write-kubeconfig-mode=644

elif [[ "$HOSTNAME" =~ "server" ]]; then
    echo "[user_data.sh] Installing k3s server..."
    curl -sfL https://get.k3s.io | K3S_TOKEN="${cluster_token}" sh -s - server --server="https://${k3s_api}:6443" --tls-san="${tls_san}" --vpn-auth="name=tailscale,joinKey=${tailscale_auth_key}" --write-kubeconfig-mode=644

else
    echo "[user_data.sh] Installing k3s agent..."
    curl -sfL https://get.k3s.io | K3S_TOKEN="${cluster_token}" sh -s - agent --server="https://${k3s_api}:6443" --vpn-auth="name=tailscale,joinKey=${tailscale_auth_key}"
fi

echo "[user_data.sh] Done!"
