# Slightly Faster Firefox Javascript performance. See:
# - http://forums.mozillazine.org/viewtopic.php?f=23&t=1948595&p=13825877&hilit=environment#p13825877
# - https://developer.mozilla.org/en-US/docs/Mozilla/Benchmarking#GC_Poisoning
export JSGC_DISABLE_POISONING=1

# Use xinput2
# See https://news.ycombinator.com/item?id=18974228
export MOZ_USE_XINPUT2=1

# Use WebRender
export MOZ_WEBRENDER=1

# Native KDE file dialogs for Firefox and Thunderbird
# See https://www.reddit.com/r/linux/comments/a59ip5/firefox_640_released/eblfwcb/
# Causes crashes on Thunderbird <68.
export GTK_USE_PORTAL=1