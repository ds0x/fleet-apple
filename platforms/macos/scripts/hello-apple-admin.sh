#!/bin/sh
# LESSON 6: post-install script for the swiftDialog FMA.
# swiftDialog installs the `dialog` binary at /usr/local/bin/dialog.
/usr/local/bin/dialog --title "Fleet" --message "Hello Apple admin!" --button1text "Hello back 👋"
exit 0
