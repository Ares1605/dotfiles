## Dependencies
`zsh`, `pacman`, `yay`

## Key Event Viewer

Run `wev` in a terminal and press the keys you're interested in to capture the key codes.

## Volume Control, Playback Control & Brightness

We're using `swayosd-client` to adjust these configurations on the fly, using `swayosd-server` via `exec-once`.

## Browser

We use Firefox with a fairly minimal configuration. `firefox-chrome` should link the `chrome` folder in Firefox's profile directory (You can find `Profile Directory` in `about:support`). The path should be:

```
$HOME/.mozilla/firefox/qxaokg8k.default-release
```

This includes primarily transparency styling.

## Weather Configuration (wego)

To set up wego with your API key:

1. Copy `.wegorc.template` to `.wegorc`
2. Edit `.wegorc` and replace `YOUR_API_KEY_HERE` with your actual OpenWeatherMap API key
3. The `.wegorc` file is gitignored to protect your API key

## Mycli Configuration

To setup login paths (server configs) with mycli, use `mysql_config_editor`:

```bash
mysql_config_editor set --login-path=my_server_alias --host=my.host.address --user=myusername --password
```

And connect to that configuration via:

```bash
mycli --login-path my_server_alias
```

## Bluetooth

Use `bluetui` for Bluetooth management.

## Google Calendar Integration

Google Calendar integration is done with `gcalcli`! Here are some favorite commands:

```bash
gcalcli agenda
gcalcli calm
```

## ZSH Vi Mode
These dotfiles utilize the [`zsh-vi-mode`](https://github.com/jeffreytse/zsh-vi-mode) plugin
