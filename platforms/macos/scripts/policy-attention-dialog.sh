#!/bin/sh
# LESSON 5: remediation script attached to a failing policy.
# Uses swiftDialog (installed in Lesson 6) to tell the user what's wrong.
# NOTE: order matters in class — install swiftDialog before wiring this up,
# or the dialog call will no-op.
if [ -x /usr/local/bin/dialog ]; then
  /usr/local/bin/dialog \
    --title "Fleet needs your attention" \
    --message "This Mac failed a compliance policy. Fleet ran this script automatically to let you know. 🛠️" \
    --button1text "On it"
else
  echo "swiftDialog not installed; logging instead: policy remediation fired."
fi
exit 0
