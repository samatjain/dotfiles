# Slightly Faster Firefox Javascript performance. See:
# - http://forums.mozillazine.org/viewtopic.php?f=23&t=1948595&p=13825877&hilit=environment#p13825877
# - https://developer.mozilla.org/en-US/docs/Mozilla/Benchmarking#GC_Poisoning
export JSGC_DISABLE_POISONING=1

# Use xinput2
# See https://news.ycombinator.com/item?id=18974228
# Disabled on desktops; scrolling can lag.
#export MOZ_USE_XINPUT2=1

# Use WebRender
# Equivalent of gfx.webrender.all = true
# Enabled by default on Firefox >= 89
# Disabled; causes deadlocks? Use pref instead.
#export MOZ_WEBRENDER=1
# Enable acceleration on Linux.
# Equivalent of layers.acceleration.force-enabled = true
export MOZ_ACCELERATED=1

# Native KDE file dialogs for Firefox and Thunderbird
# See https://www.reddit.com/r/linux/comments/a59ip5/firefox_640_released/eblfwcb/
# Causes crashes on Thunderbird <68.
export GTK_USE_PORTAL=1

# Enable EGL and VA-API
# from https://www.reddit.com/r/firefox/comments/igcafy/firefox_800_see_all_new_features_updates_and_fixes/g2w6eme/?context=3
# Also set in about:config:
# • gfx.x11-egl.force-enabled = true
# • media.ffmpeg.vaapi.enabled = true
# • media.ffvpx.enabled = false
# Supposedly this variable no longer does anything in Firefox > 88, the
# above prefs.js settings are used instead.
export MOZ_X11_EGL=1
