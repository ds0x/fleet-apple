#!/bin/bash
# Regenerate fleets/student-NN.yml files. Usage: ./generate-student-fleets.sh [count]
# Default 30. Existing files are overwritten (they're meant to be identical).
#
# Enroll secrets: NN-$FLEET_ENROLLMENT_AFFIX, expanded by fleetctl at apply
# time. The affix lives in a GitHub Actions repository *variable* (and your
# local env for manual runs). It must be ≥29 chars so NN- + affix clears
# Fleet's 32-character minimum for enroll secrets.
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

settings:
  secrets:
    - secret: $i-\$FLEET_ENROLLMENT_AFFIX

controls:

software:
YML
done
echo "Generated $COUNT student fleet files in fleets/."
