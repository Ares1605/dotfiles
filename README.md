Key event viewer -
  Run wev in a terminal, and press the keys you're interested in to capture the key codes.
Volume control? Playback control? Brightness
  We're using the swayosd-client to adjust these configurations on the fly, using the swayosd-server via exec-once.

## Browser
We use Firefox with a fairly minimal configuration. `firefox-chrome` should link the `chrome` folder in Firefoxs profile
directory (You can find `Profile Directory` in about:support, however *should* be sh```$HOME/.mozilla/firefox/qxaokg8k.default-release```). This includes primarily transparency styling.

## Weather Configuration (wego)
To set up wego with your API key:
1. Copy `.wegorc.template` to `.wegorc`
2. Edit `.wegorc` and replace `YOUR_API_KEY_HERE` with your actual OpenWeatherMap API key
3. The `.wegorc` file is gitignored to protect your API key

## Mycli Configuration
To setup login paths (server configs) with mycli, use mysql_config_editor:
sh```mysql_config_editor set --login-path=my_server_alias --host=my.host.address --user=myusername --password```
And connect to that configuration via:
sh```mycli --login-path my_server_alias```

## Bluetooth
bluetui

## Google Calendar Integration
Google Calendar integration is done with gcalcli! Here are some favorite commands:
sh```gcalcli agenda```
sh```gcalcli calm```
