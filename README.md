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

## Firefox

#### Troubleshooting
If you still don't see styling and/or configuration (at the time of this commit styling included a Firefox transparent header and configuration included not auto hiding Firefox headers), there's a chance the setup script didn't symlink your Firefox files properly. In that case, perform the following:
1. Open Firefox, type `about:support` in the Firefox browser and press Enter.
2. Under `Application Basics`, copy the value of `Profile Directory`. In most cases, the value exists as `/home/YOUR_USER/.mozilla/firefox/SOME_RELEASE_NUMBER.default-release`
3. Execute the following in Kitty:
```bash
ln -s ~/.dotfiles/firefox-chrome THE_DIRECTORY_YOUR_COPIED/chrome
ln -s ~/.dotfiles/firefox-user.js THE_DIRECTORY_YOUR_COPIED/user.js
```
The first `firefox-chrome` command should symlink your chrome directory to fix styling issues, and the second `firefox-user.js` command should symlink your configuration file.

Note: `firefox-user.js` must be properly symlinked to `firefox-chrome` to modify anything. More information [here](https://www.reddit.com/r/FirefoxCSS/wiki/index/tutorials/)

Note: This assumes you're dotfiles exists under `~/.dotfiles`. Adjust the command accordingly.

<details>
  <summary>More information on troubleshooting</summary>
  
  #### Enable userChrome customization in about:config

  1. Navigate to `about:config` via the address bar and click the 'Accept the Risk and Continue' button if it appears.
  2. Search for `toolkit.legacyUserProfileCustomizations.stylesheets` and toggle it to `true` by double-clicking it.

  [Source](https://www.reddit.com/r/FirefoxCSS/wiki/index/tutorials/)
</details>

#### Recommended additional configurations
Add the following extension to Firefox: [Ctrl+Number to switch tabs](https://addons.mozilla.org/en-US/firefox/addon/ctrl-number-to-switch-tabs/)
