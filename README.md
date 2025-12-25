## Setup
Add the following to your .zshrc file:


```bash
export DOTFILES_PATH="[YOUR DOTFILES PATH]"
```

And change the `[YOUR DOTIFLES PATH]` where this repository points (ie. `$HOME/.dotfiles`).

## Dependencies
`zsh`, `pacman`, `yay`, `git`

## Key Event Viewer

Run `wev` in a terminal and press the keys you're interested in to capture the key codes.

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
ln -s $DOTFILES_PATH/firefox-chrome THE_DIRECTORY_YOUR_COPIED/chrome
ln -s $DOTFILES_PATH/firefox-user.js THE_DIRECTORY_YOUR_COPIED/user.js
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


## Local MySQL
The `mysql` package is used for spinning up a local mysql instance. This uses the `mysqld.service` for initialization.

To spin up a local server:
```bash
systemctl start mysqld
```

## Magic Wormhole / Destiny
Magic Wormhole CLI (`wormhole-william-bin` in the AUR) offers an E2E encrypted method to send/receive media/files between your devices and your desktop.

Destiny is an E2E encrypted app to share files between your desktop and your selected device. It implements the Magic Wormhole, which offers a solution to easily transfer files between an iOS phone to your desktop.

Downloading `Destiny - Secure File Transfer` on iOS includes a simple client to send media/files via on-the-fly generated codes that would be shared with your desktop, in which the Magic Wormhole protocol initializes a P2P connection to make the data transfer.

Here's a simple walkthrough example of transferring an image from an iOS phone to your desktop.

```
+---------------------------+              +------------------------------+
|           iPhone          |              |            Desktop           |
+---------------------------+              +------------------------------+
|                           |              |                              |
| 1) Open Destiny app       |              |                              |
|                           |              |                              |
| 2) Tap "Select a Media"   |              |                              |
|                           |              |                              |
| 3) Pick the photo         |              |                              |
|                           |              |                              |
| 4) Destiny generates      |              |                              |
|    code: ie 7-horse-fox   |              |                              |
|              |            |              |                              |
|              |  read /    |              |                              |
|              |  copy      |              |                              |
|              v            |              |                              |
|                           |              | 5) In a terminal:            |
|                           |              |                              |
|                           |              |    $ wormhole-william        |
|                           |              |      receive 7-horse-fox     |
|                           |              |                              |
|                           |              | 6) File downloaded as        |
|                           |              |    ./[filename]              |
|                           |              |    (E2E transfer done)       |
+---------------------------+              +------------------------------+
```

Take a look at `setup-scripts/setup-otp/entry.sh` for a working example of `wormhole-william`!

## AndCLI
AndCLI is the lazy 2FA solution for accessing authentication codes on your desktop. To setup AndCLI to sync with your
Google Authenticator app, do the following:

1. Go to Google Authenticator on the device you'd like to import codes from
2. Click on the hamburger, select "Transfer accounts", and select "Exports accounts"
3. After inputting your password and pressing "Next", screenshot each QR code, trimming the photo to the dimensions of the QR code.
4. Open the Destiny app on your phone, and run the `setup-scripts/setup-otp/entry.sh` file, following the instructions.
5. After you've downloaded all the QR codes to your computer using the Destiny app via `entry.sh`, and typed your password, AndCLI will be properly setup, using the Authenticator app secrets in the `~/vault.kdbx`, protected by your password.

Note: If you use something other than Google Authenticator, the script will likely not work, even if you export QR codes. Take a look at the `entry.sh` code to evaluate what needs to be modified to fit your app.

## Toggl Track
`toggl` (`toggl-cli-bin` in the AUR) is used to quickly mutate Toggl entries. Some common commands:

```bash
toggl start My Description
```

```bash
toggl stop
```

```bash
toggl list
```

## Wf-recorder
Wf-recorder is a screen capture CLI that offers audio and video screen capture, with define ranges. Wf-recorder is used for the `Screen Capture` application.
Use the `Screen Capture` application to invoke the `scripts/screen-capture-launcher.sh` script, which will capture the screen from the range you provide it.

This is useful to quickly screen capturing without the mental and physical overhead of using OBS.

Note: Waybar will show a red ⏺ when a wf-recorder process is running (via `pgrep -x wf-recorder`)!
