# FCAA class — Fleet GitOps repo

Backing repo for the **Fleet-certified Apple Administrator** classroom
instance. It pins the class baseline as code so setup is repeatable and
the post-class reset is one apply.

Layout mirrors what `fleetctl new` generates (`default.yml`, `fleets/`,
`labels/`, `platforms/<os>/…`). Regenerating with
`fleetctl new --dir . --force` is safe — it refreshes the CI scaffolding;
class files in `fleets/`, `labels/`, and `platforms/` are additive.

## What's here

| Path | Purpose |
|---|---|
| `default.yml` | Org settings + global labels. AB/VPP blocks left commented — **ds connects APNs / Apple Business / VPP by hand** and assigns the VPP token to every student fleet in the UI. |
| `fleets/student-01…30.yml` | 30 empty student sandboxes. Empty-by-design: the reset apply removes everything students created. Regenerate/resize with `tools/generate-student-fleets.sh [count]`. |
| `fleets/demo-workstations.yml` | Instructor demo fleet with the full sample wiring (profiles, declarations, scripts, reports, policies, swiftDialog FMA). |
| `fleets/demo-mobile.yml` | iOS/iPadOS demo fleet (Lesson 2 enrollment-URL demo, BYOD-vs-company split). |
| `labels/` | `Test Macs` (manual — Lesson 6 scope target), `Virtual Macs` (dynamic, matches UTM/Tart VMs), `Apple Silicon macOS hosts`. |
| `platforms/macos/configuration-profiles/` | Lesson 7 samples: **fleet-webclip** (demo), **login-window-message** (student task), **dock-settings** (spare, very visible). |
| `platforms/macos/declaration-profiles/` | **test-echo.json** — DDM test declaration, zero device impact (student task). `passcode-settings.json.example` — real-world shape, disabled for lab VMs. |
| `platforms/macos/scripts/` | `hello-apple-admin.sh` (swiftDialog post-install, Lesson 6) · `policy-attention-dialog.sh` (policy remediation, Lesson 5). |
| `platforms/macos/policies/` | `swiftdialog-installed` (EXISTS + install-software automation) · `gatekeeper-enabled` (EXISTS + run_script). |
| `platforms/*/reports/` | `uptime` (all) · `battery-health` (physical-Mac wow query) · `hardware-identity` (unique per student). |
| `tools/` | `generate-student-fleets.sh` · `reset-class.sh` (dry-run, confirm, apply). |

## Setup

1. Create the repo from this directory; push to GitHub.
2. Add repository secrets: `FLEET_URL`, `FLEET_API_TOKEN` (API-only user
   with the GitOps role), `FLEET_GLOBAL_ENROLL_SECRET`.
3. Run the **Apply latest configuration to Fleet** workflow once
   (or `tools/reset-class.sh` locally) to create fleets + baseline.
4. By hand (ds): connect APNs, Apple Business, VPP; assign the VPP token
   to all student fleets; create student accounts (fleet **admin** on
   their own fleet); add lab-host serials to the `Test Macs` label.
5. Enrollment of VMs + the physical device: handled by ds.

## Class-day rule

**No applies during class.** GitOps reconciles the instance to this repo —
an apply mid-class would wipe student work. Apply only for setup and reset.

## Reset between cohorts

```
./tools/reset-class.sh
```

Dry-runs first, asks for confirmation, then restores the baseline
(students' labels/reports/policies/software/profiles are removed because
the student fleet files declare an empty state). Rotate enroll secrets
afterwards if you want a fully clean slate.

## Verify-before-class list

- swiftDialog FMA slug (`swiftdialog/darwin`) still matches the catalog.
- Mactracker's Mac App Store ID in Apple Business before uncommenting the
  VPP block in `fleets/demo-workstations.yml`.
- Profiles validate: `contour profile normalize platforms/macos/configuration-profiles -r`.
