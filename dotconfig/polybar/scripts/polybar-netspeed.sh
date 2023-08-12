#!/bin/bash

rx_bytes_old=0
tx_bytes_old=0

while true; do
    rx_bytes_new=0
    tx_bytes_new=0
    for iface in $(ls /sys/class/net/ | grep -E '^(en|eth|wlan|wl|tun|tap)'); do
        stats=$(cat /sys/class/net/"$iface"/statistics/{rx,tx}_bytes 2>/dev/null || echo 0 0)
        read -r rx_bytes tx_bytes <<< "$stats"
        rx_bytes_new=$((rx_bytes_new + rx_bytes))
        tx_bytes_new=$((tx_bytes_new + tx_bytes))
    done

    rx_speed=$((rx_bytes_new - rx_bytes_old))
    tx_speed=$((tx_bytes_new - tx_bytes_old))

    rx_bytes_old=$rx_bytes_new
    tx_bytes_old=$tx_bytes_new

    echo "$(numfmt --to=iec-i --suffix=B --format='%.1f' $rx_speed)  $(numfmt --to=iec-i --suffix=B --format='%.1f' $tx_speed)"

    sleep 1
done

