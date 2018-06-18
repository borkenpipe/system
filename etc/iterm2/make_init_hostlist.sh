#!/bin/bash -x

cat colors.json | jq -r '.Colors[] | ["",.Name,""] | @csv' | sed 's/"//g' > hosts.csv.blank
cat hosts.csv.blank
ls -l hosts.csv.blank

