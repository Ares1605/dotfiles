// Mozilla User Preferences (safe public version)
// Sanitized for dotfiles — excludes personal data, UUIDs, and transient state.

user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("accessibility.uia.enable", 2);

// General UX
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.contentblocking.category", "standard");
user_pref("browser.fullscreen.autohide", false);
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
user_pref("browser.tabs.allow_transparent_browser", true);
user_pref("browser.toolbarbuttons.introduced.sidebar-button", true);
user_pref("browser.urlbar.autoFill.adaptiveHistory.enabled", true);
user_pref("browser.urlbar.autoFill.typed", true);
user_pref("browser.urlbar.suggest.history.onlyTyped", true);
user_pref("browser.urlbar.placeholderName", "Google");

// DevTools
user_pref("devtools.cache.disabled", true);
user_pref("devtools.debugger.pause-on-debugger-statement", false);
user_pref("devtools.performance.recording.features", "[\"screenshots\",\"js\",\"cpu\",\"memory\"]");
user_pref("devtools.performance.recording.threads", "[\"GeckoMain\",\"Compositor\",\"Renderer\",\"DOM Worker\"]");
user_pref("devtools.toolbox.zoomValue", "0.8");

// Graphics
user_pref("gfx.webrender.all", true);
user_pref("layers.acceleration.disabled", true);
user_pref("layers.acceleration.force-enabled", true);

// Privacy & Security
user_pref("doh-rollout.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("privacy.clearHistory.formdata", true);
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3", true);
user_pref("privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs", true);

// Downloads (sanitized path)
user_pref("browser.download.lastDir", "~/Downloads");
user_pref("browser.download.panel.shown", true);

// PDF & accessibility
user_pref("pdfjs.enableAltText", true);
user_pref("pdfjs.enableAltTextForEnglish", true);

// Custom UI and appearance
user_pref("svg.context-properties.content.enabled", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("ui.key.menuAccessKeyFocuses", false);

// Misc safe defaults
user_pref("browser.shell.checkDefaultBrowser", true);
user_pref("browser.proton.toolbar.version", 3);
user_pref("distribution.iniFile.exists.value", true);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
user_pref("browser.aboutwelcome.didSeeFinalScreen", true);
