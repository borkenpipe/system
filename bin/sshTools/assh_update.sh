#!/bin/bash

cd ~/.ssh/ || exit 43
$EDITOR assh.yml
assh config build assh.yml > config
$EDITOR config

