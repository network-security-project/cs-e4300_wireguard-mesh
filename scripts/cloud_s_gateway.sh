#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.30.30.1

## Outbound NAT
iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

## FULL CONE TO SERVER
iptables -t nat -A PREROUTING -p udp --source 172.16.16.16 --dport 4444 -j DNAT --to-destination 10.1.0.2:4444
iptables -t nat -A PREROUTING -p udp --source 172.18.18.18 --dport 5555 -j DNAT --to-destination 10.1.0.2:5555


## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

