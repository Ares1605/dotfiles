Key event viewer -
  Run wev in a terminal, and press the keys you're interested in to capture the key codes.
Volume control? Playback control? Brightness
  We're using the swayosd-client to adjust these configurations on the fly, using the swayosd-server via exec-once.

## Weather Configuration (wego)
To set up wego with your API key:
1. Copy `.wegorc.template` to `.wegorc`
2. Edit `.wegorc` and replace `YOUR_API_KEY_HERE` with your actual OpenWeatherMap API key
3. The `.wegorc` file is gitignored to protect your API key
