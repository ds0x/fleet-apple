#!/bin/bash
# Regenerate fleets/student-NN.yml files. Usage: ./generate-student-fleets.sh [count]
# Default 30. Existing files are overwritten (they're meant to be identical).
set -euo pipefail
COUNT="${1:-30}"
cd "$(dirname "$0")/.."
for i in $(seq -w 1 "$COUNT"); do
cat > "fleets/student-$i.yml" <<YML
# student-$i — FCAA class sandbox fleet.
#
# Intentionally minimal: students build labels, reports, policies,
# software, and controls BY HAND in the UI during class. Because this
# file declares an empty baseline, the post-class GitOps apply resets
# the fleet by removing everything students created.
name: "student-$i"

controls:

software:
YML
done
echo "Generated $COUNT student fleet files in fleets/."
