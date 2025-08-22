#!/bin/bash
hosts=("8.8.8.8" "1.1.1.1" "uptime-kuma.example.com")
for h in "${hosts[@]}"; do
    ping -c 3 $h | tail -2
done
