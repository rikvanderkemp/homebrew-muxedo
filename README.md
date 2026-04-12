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
