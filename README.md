# homebrew-muxedo

Homebrew tap for [muxedo](https://github.com/rikvanderkemp/muxedo).

```bash
brew tap rikvanderkemp/muxedo
brew install muxedo
```

Prefer `brew upgrade muxedo` for updates; the binary also supports self-update via GitHub releases (Homebrew metadata may lag until the tap is bumped).

## Local test

```bash
brew tap rikvanderkemp/muxedo "$(pwd)"
brew install muxedo
brew test muxedo
brew audit muxedo
brew untap rikvanderkemp/muxedo   # optional cleanup
```

Use a clone of this repo (needs `git` history — `brew tap` clones the directory).

## Maintainer: release automation

After each muxedo GitHub release (non-major), the [muxedo](https://github.com/rikvanderkemp/muxedo) workflow can notify this repo via `repository_dispatch` so [`.github/workflows/bump-formula.yml`](.github/workflows/bump-formula.yml) opens a PR that bumps [`Formula/muxedo.rb`](Formula/muxedo.rb) using `checksums.txt` from the release.

**In the muxedo repo (caller):** add Actions secret `HOMEBREW_MUXEDO_DISPATCH_TOKEN` — a PAT that can trigger dispatch on **`rikvanderkemp/homebrew-muxedo`** (classic: `repo` on that repo; fine-grained: **Contents: Read and write** on that repo only). If unset, the dispatch step is skipped (release still succeeds).

**In this repo:** no extra secrets — the bump workflow uses `GITHUB_TOKEN` to push a branch and open a PR.

**Manual test:** Actions → **Bump formula** → *Run workflow* → enter tag `v0.1.8` (must match an existing muxedo release with assets). Or send dispatch:

```bash
echo '{"event_type":"muxedo-release","client_payload":{"tag":"v0.1.8"}}' \
  | gh api repos/rikvanderkemp/homebrew-muxedo/dispatches --input -
```

Event type must be `muxedo-release` (see workflow `on.repository_dispatch.types`).