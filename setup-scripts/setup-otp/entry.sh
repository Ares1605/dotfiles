#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setup AndCLI process started!"
echo
echo "For every QR code you've screenshotted and uploaded to the Destiny iOS app, specify the code provided:"
echo

otps_sum=""

while true; do
  read -p "Destiny wormhole code (keep empty to proceed to next step): " code
  if [[ -z $code ]]; then
    break
  fi

  code_output_dir=$(mktemp -d)
  cd $code_output_dir
  echo
  echo y | wormhole-william receive $code
  code_path=$(ls)
  decoded=$(zbarimg --raw $code_path)
  if [[ -z $decoded ]]; then
    echo
    echo "zbarimg failed to decode the QR code at $code_path, exitting program"
    exit 1
  else
    ls $code_output_dir
    # rm -rf $code_output_dir
    # mkdir $code_output_dir
  fi

  otps=$(otpauth -link $decoded)
  otps_count=$(echo $otps | tr -cd " " | wc -c)
  echo "$otps_count account(s) found from QR code"
  echo
  otps_sum="$otps_sum $otps"
done

otps_sum_count=$(echo $otps_sum | tr -cd " " | wc -c)
echo
echo "Completed gathering $otps_sum_count accounts!"
echo

read -s -p "Create a password for the vault: " password

cd $SCRIPT_DIR
python -m venv .venv
source .venv/bin/activate
pip install pykeepass
python setup.py "$password" "$otps_sum"

echo "completed!"
