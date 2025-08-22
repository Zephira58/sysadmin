#!/bin/bash
echo "Top CPU processes:"
ps aux --sort=-%cpu | head -n 10
echo "Top Memory processes:"
ps aux --sort=-%mem | head -n 10
