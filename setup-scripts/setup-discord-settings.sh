#!/bin/bash

path="$HOME/.config/discord/settings.json"

if [[ ! -f $path ]]; then
  echo "$path file is not found. This is not unexpected. Open Discord to initialize a settings.json if it was not auto-generated."
  exit 1
fi

echo "Adding SKIP_HOST_UPDATE = true to settings.json (More information: https://www.reddit.com/r/linuxmasterrace/comments/10bq9qq/discords_lucky_day_hits_arch_btw_once_again_with/)"
jq '.SKIP_HOST_UPDATE = true' ~/.config/discord/settings.json > /tmp/discord-settings.json && mv /tmp/discord-settings.json ~/.config/discord/settings.json
