#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setup AndCLI process started!"
echo

export_directory=$(mktemp -d) || exit 1
ente-cli account update --email aresstav04@gmail.com --app auth --dir "$export_directory"
ente-cli export --emails aresstav04@gmail.com

otps=$(cat "$export_directory/ente_auth.txt") || exit 1

read -s -p "Type the password for the vault: " password

cd $SCRIPT_DIR
python -m venv .venv
source .venv/bin/activate
pip install pykeepass
python setup.py "$password" "$otps"

echo "completed!"
