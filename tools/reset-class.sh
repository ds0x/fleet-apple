#!/bin/bash
# Post-class reset: re-applies the baseline, wiping student-created
# labels/reports/policies/software/profiles from every fleet.
# Requires: fleetctl installed + FLEET_URL, FLEET_API_TOKEN,
# FLEET_GLOBAL_ENROLL_SECRET exported.
set -euo pipefail
cd "$(dirname "$0")/.."
: "${FLEET_URL:?export FLEET_URL first}"
: "${FLEET_API_TOKEN:?export FLEET_API_TOKEN first}"
: "${FLEET_GLOBAL_ENROLL_SECRET:?export FLEET_GLOBAL_ENROLL_SECRET first}"

ARGS=(-f default.yml)
for f in fleets/*.yml; do ARGS+=(-f "$f"); done

echo "→ Dry run first…"
fleetctl gitops --dry-run "${ARGS[@]}"
read -r -p "Apply for real? [y/N] " yn
[ "$yn" = "y" ] && fleetctl gitops "${ARGS[@]}" && echo "✅ Class baseline restored."
