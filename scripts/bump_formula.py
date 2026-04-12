#!/usr/bin/env python3
"""Update Formula/muxedo.rb version and sha256 lines from checksums.txt (sha256sum format)."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

# Order must match Formula/muxedo.rb: darwin arm, darwin amd64, linux arm, linux amd64
SHA256_ORDER = ("darwin_arm64", "darwin_amd64", "linux_arm64", "linux_amd64")


def normalize_tag(tag: str) -> str:
    tag = tag.strip()
    if not tag.startswith("v"):
        tag = "v" + tag
    return tag


def semver_from_tag(tag: str) -> str:
    return normalize_tag(tag).lstrip("v")


def parse_checksums(content: str) -> dict[str, str]:
    """Map platform key (e.g. darwin_arm64) -> sha256 hex."""
    out: dict[str, str] = {}
    for line in content.splitlines():
        line = line.strip()
        if not line:
            continue
        parts = line.split(None, 1)
        if len(parts) < 2:
            continue
        digest, name = parts[0], parts[1].lstrip("*")
        if not re.fullmatch(r"[a-f0-9]{64}", digest):
            continue
        m = re.search(r"muxedo_[0-9.]+_((?:darwin|linux)_(?:arm64|amd64))\.tar\.gz$", name)
        if m:
            out[m.group(1)] = digest
    return out


def bump_formula(formula_path: Path, semver: str, hashes: dict[str, str]) -> None:
    for key in SHA256_ORDER:
        if key not in hashes:
            sys.exit(f"missing checksum for {key} in checksums (got keys: {sorted(hashes)!r})")

    text = formula_path.read_text()
    new_text, n = re.subn(r'version "[^"]+"', f'version "{semver}"', text, count=1)
    if n != 1:
        sys.exit("failed to replace version line exactly once")
    text = new_text

    # Replace each sha256 in place using unique URL line (sequential re.subn(count=1) would
    # hit the same first sha256 line every time when hashes match previous values).
    platform_snippet = {
        "darwin_arm64": r"darwin_arm64\.tar\.gz",
        "darwin_amd64": r"darwin_amd64\.tar\.gz",
        "linux_arm64": r"linux_arm64\.tar\.gz",
        "linux_amd64": r"linux_amd64\.tar\.gz",
    }
    for key in SHA256_ORDER:
        new_h = hashes[key]
        pat = (
            r'("https://github\.com/rikvanderkemp/muxedo/releases/download/v#\{version\}/muxedo_#\{version\}_'
            + platform_snippet[key]
            + r'"\s*\n\s*sha256 ")[a-f0-9]{64}(")'
        )
        text, n = re.subn(pat, rf"\g<1>{new_h}\2", text, count=1)
        if n != 1:
            sys.exit(f"failed to replace sha256 for {key} exactly once (n={n})")

    formula_path.write_text(text)


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--tag", required=True, help="Release tag, e.g. v0.1.8")
    p.add_argument("--checksums", required=True, type=Path, help="Path to checksums.txt")
    p.add_argument("--formula", required=True, type=Path, help="Path to muxedo.rb")
    args = p.parse_args()

    semver = semver_from_tag(args.tag)
    hashes = parse_checksums(args.checksums.read_text())
    bump_formula(args.formula, semver, hashes)
    print(f"Bumped formula to {semver}", file=sys.stderr)


if __name__ == "__main__":
    main()
