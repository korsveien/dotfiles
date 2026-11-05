#!/usr/bin/env python3
"""Write ~/.config/zed/settings.json from the dotfiles base and the local overlay ~/.config/zed-local/work.json."""
import argparse
import difflib
import hashlib
import json
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parent / "settings.json"
LOCAL_DIR = Path.home() / ".config" / "zed-local"
OVERLAY = LOCAL_DIR / "work.json"
CHECKSUM = LOCAL_DIR / "settings.sha256"
TARGET = Path.home() / ".config" / "zed" / "settings.json"


def strip_jsonc(text: str) -> str:
    out = []
    i = 0
    in_string = False
    while i < len(text):
        c = text[i]
        if in_string:
            out.append(c)
            if c == "\\":
                out.append(text[i + 1])
                i += 1
            elif c == '"':
                in_string = False
        elif c == '"':
            in_string = True
            out.append(c)
        elif text.startswith("//", i):
            while i < len(text) and text[i] != "\n":
                i += 1
            continue
        elif text.startswith("/*", i):
            i = text.index("*/", i) + 2
            continue
        else:
            out.append(c)
        i += 1
    return remove_trailing_commas("".join(out))


def remove_trailing_commas(text: str) -> str:
    out = []
    in_string = False
    for i, c in enumerate(text):
        if in_string:
            if c == '"' and text[i - 1] != "\\":
                in_string = False
        elif c == '"':
            in_string = True
        elif c == ",":
            rest = text[i + 1 :].lstrip()
            if rest[:1] in ("}", "]"):
                continue
        out.append(c)
    return "".join(out)


def load(path: Path) -> dict:
    return json.loads(strip_jsonc(path.read_text()))


def merge(base: dict, overlay: dict) -> dict:
    result = dict(base)
    for key, value in overlay.items():
        if isinstance(value, dict) and isinstance(result.get(key), dict):
            result[key] = merge(result[key], value)
        else:
            result[key] = value
    return result


def sha256(text: str) -> str:
    return hashlib.sha256(text.encode()).hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-f", "--force", action="store_true", help="overwrite changes that Zed made to the generated file")
    parser.add_argument("-n", "--dry-run", action="store_true", help="print the generated settings to stdout and write nothing")
    args = parser.parse_args()
    try:
        return build(args.force, args.dry_run)
    except KeyboardInterrupt:
        return 130


def build(force: bool, dry_run: bool) -> int:
    settings = load(BASE)
    if OVERLAY.exists():
        settings = merge(settings, load(OVERLAY))
    generated = json.dumps(settings, indent=2, ensure_ascii=False) + "\n"

    if dry_run:
        sys.stdout.write(generated)
        return 0

    if TARGET.resolve() == BASE:
        print(f"{TARGET} points to {BASE}. Run ln.sh to make ~/.config/zed a normal folder.", file=sys.stderr)
        return 1

    if TARGET.exists() and not force:
        current = TARGET.read_text()
        recorded = CHECKSUM.read_text().strip() if CHECKSUM.exists() else None
        if current != generated and sha256(current) != recorded:
            diff = difflib.unified_diff(
                generated.splitlines(keepends=True),
                current.splitlines(keepends=True),
                "generated",
                str(TARGET),
            )
            sys.stderr.writelines(diff)
            print(
                f"\n{TARGET} has changes that are not in {BASE} or {OVERLAY}.\n"
                "Move the changes to one of these files, then run this script again, or use --force.",
                file=sys.stderr,
            )
            return 1

    TARGET.parent.mkdir(parents=True, exist_ok=True)
    TARGET.write_text(generated)
    LOCAL_DIR.mkdir(parents=True, exist_ok=True)
    CHECKSUM.write_text(sha256(generated) + "\n")
    print(f"wrote {TARGET}" + (f" with {OVERLAY}" if OVERLAY.exists() else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
