# Hybrid-Lab-Setup


## Hosts

| Role   | Host                          | Location                  | Type                | CPU   | RAM | Storage |
| ----   | ----------------------------- | ------------------------- | ------------------- | ----- | --- | ------- |
| Master | A1-Toronto-AD1-Ubuntu-OCPU1-1 | Oracle - Canada Southeast | VM.Standard.A1.Flex | 1 Arm | 6Gb | 47Gb    |
| Worker | A1-Toronto-AD1-Ubuntu-OCPU1-2 | Oracle - Canada Southeast | VM.Standard.A1.Flex | 1 Arm | 6Gb | 47Gb    |
| Master | pios64-b84b                   | Home - Local              | Raspberry Pi 4 8Gb  | 4 Arm | 8Gb | 120Gb   |
| Worker | pios64-35aa                   | Home - Local              | Raspberry Pi 4 8Gb  | 4 Arm | 8Gb | 120Gb   |
| Worker | pios64-358d                   | Home - Local              | Raspberry Pi 4 8Gb  | 4 Arm | 8Gb | 120Gb   |


## Networking

For ranges see [wikipedia(https://en.wikipedia.org/wiki/Reserved_IP_addresses)

| Range in Use   | Use                        |  Full Range     | Details                                    |
| -------------- | -------------------------- |  -------------- | ------------------------------------------ | 
| 100.66.0.0/16  |  ISP - Carrier Grade NAT   |  100.64.0.0/10  |  100.64. 0.0  to 100.127.255.255           |
| 192.168.1.0/18 |  Router - Local            |  192.168.1.0/18 |  192.168.0.0  to 192.168. 63.255           | 
| 10.0.0.0/16    |  Cloud/Internal            |  10.0.0.0/8     |  10.0.0.0     to  10.?.?.?                 |
| 172.16.0.0/24  |  Wireguard                 |  172.16.0.0/12  |  172.16.0.0   to 172.?.?.?                 |

## ssh

- Prepare ssh config file to have the hostnames, IPs as well as links to ssh keys for each server
- ssh to each server to check that ssh config works well

## create ssh key for local hosts (to replace password ssh)

 ssh-keygen -t ed25519

 ## copy new ssh key to local hosts

 ssh-copy-id -i ~/.ssh/local-pi-id_ed25519 pios64-b84b 
 ssh-copy-id -i ~/.ssh/local-pi-id_ed25519 pios64-35aa
 ssh-copy-id -i ~/.ssh/local-pi-id_ed25519 pios64-358d 

## update OS using ansible...

cd /mnt/c/Data/git/Hybrid-Lab-Setup

ansible-playbook playbooks/os_update.yml -i inventory/wg-inventory.yml


## Setup Wireguard

ansible-playbook -i inventory/wg-inventory.yml setup-hosts/automation-wireguard/wireguard.yml

## configure cloud instances to take wg packets in

sudo iptables -I INPUT 6 -m state --state NEW -p udp --dport 51871 -j ACCEPT
sudo netfilter-persistent save
sudo netfilter-persistent reload




## Test Wireguard

ansible-playbook -i inventory/wg-inventory.yml setup-hosts/automation-wireguard/ping.yml




