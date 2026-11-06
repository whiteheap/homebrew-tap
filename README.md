# whiteheap/homebrew-tap

Homebrew formulas for [Whiteheap](https://github.com/whiteheap) tools, on macOS and Linux.

```sh
brew install whiteheap/tap/residue
```

| Formula | What it does |
| --- | --- |
| [`residue`](https://github.com/whiteheap/residue) | Finds the Git worktrees coding agents leave behind, and removes one only when nothing in it would be lost |

Each formula installs the release binaries that the project's GitHub Actions workflow builds. The formula pins each binary's checksum, and the project repository holds a GitHub build-provenance attestation for each one.

## Invariant: one binary, no dependencies

Every formula in this tap installs a single prebuilt binary and has no `depends_on`. The Linux binaries are static (musl). The macOS binaries link only the system libraries in `/usr/lib`, never a Homebrew library. So installing or upgrading a formula from this tap changes nothing else in the Homebrew prefix. Agents on a shared machine rely on this to upgrade Whiteheap formulas in a shared `/opt/homebrew`. A formula that needs a dependency breaks the invariant: change this section first, and say what the dependency is.

Each release also upgrades the maintainer's local install, so the copy we use day to day is the latest release. Upgrade in this form, so Homebrew's auto-update and install-time cleanup leave other formulas alone:

```sh
brew update && HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 brew upgrade whiteheap/tap/residue
```

Use `brew install` in place of `brew upgrade` when the formula is not installed yet.
