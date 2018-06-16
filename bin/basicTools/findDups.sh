#!/bin/bash

echo "[*] Only Repeated"
uniq -d $1
echo ""
echo "[*] Counts"
uniq -c $1

