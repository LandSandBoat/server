#!/usr/bin/env python3
"""
Format data YAML: ruamel round-trip to normalize structure (2-space indent,
single quotes, flow spacing), then a text pass to align
value/comment columns per contiguous block.

Usage: python3 tools/yaml/format.py [paths...] [--check]
       python3 tools/yaml/format.py --stdin < in.yaml > out.yaml
  paths   : files or directories to format (default: data/)
  --check : only check formatting, do not modify files (exit 1 if any differ)
  --stdin : format stdin to stdout, for editor integration

Requires ruamel.yaml and pyyaml (tools/requirements.txt); CI runs --check.
"""

import difflib
import os
import sys
from collections import namedtuple
from io import StringIO
from pathlib import Path

REEXEC_GUARD = "LSB_FORMAT_YAML_REEXEC"


def cmake_python():
    """
    Interpreter CMake configured for the build (from CMakeCache.txt), or None.
    The build installs tools/requirements.txt into it, so it is a good fallback
    when an editor launches a python that lacks the deps.
    """
    root = Path(__file__).resolve().parents[2]
    globs = (
        "build*/CMakeCache.txt",
        "build*/*/CMakeCache.txt",
        "cmake-*/CMakeCache.txt",
        "out/*/CMakeCache.txt",
    )
    caches = sorted(
        (c for g in globs for c in root.glob(g)),
        key=lambda p: p.stat().st_mtime,
        reverse=True,
    )
    for cache in caches:
        try:
            for line in cache.read_text(encoding="utf-8", errors="ignore").splitlines():
                if "Python_EXECUTABLE:" in line and "=" in line:
                    path = line.split("=", 1)[1].strip()
                    if path and "NOTFOUND" not in path and Path(path).is_file():
                        return path
        except OSError:
            continue
    return None


try:
    import yaml as pyyaml
    from ruamel.yaml import YAML
except ImportError as exc:
    # Retry through the build's interpreter, which has the deps installed.
    build_python = None if os.environ.get(REEXEC_GUARD) else cmake_python()
    if build_python and Path(build_python).resolve() != Path(sys.executable).resolve():
        os.environ[REEXEC_GUARD] = "1"
        os.execv(
            build_python, [build_python, str(Path(__file__).resolve()), *sys.argv[1:]]
        )
    if "--stdin" in sys.argv[1:]:  # echo back so an editor never blanks the buffer
        sys.stdout.buffer.write(sys.stdin.buffer.read())
    sys.stderr.write(
        f"format: missing dependency ({exc}) for interpreter {sys.executable}\n"
        f"  run: {sys.executable} -m pip install -r tools/requirements.txt\n"
    )
    raise SystemExit(1)


class FormatError(Exception):
    """A file could not be safely formatted; reported per-file, never fatal."""


def represent_none(dumper, _data):
    """Emit `null` spelled out; a bare key is not read back as a deletion."""
    return dumper.represent_scalar("tag:yaml.org,2002:null", "null")


def normalize(text):
    ruamel = YAML()
    ruamel.indent(mapping=2, sequence=4, offset=2)
    ruamel.width = 4096  # never wrap
    ruamel.preserve_quotes = False  # normalize quote style
    ruamel.representer.add_representer(type(None), represent_none)
    data = ruamel.load(text)
    buf = StringIO()
    ruamel.dump(data, buf)
    return buf.getvalue()


def split_comment(text):
    """Split a line body into (code, comment) honoring quotes; comment keeps '#'."""
    in_single = in_double = False
    for i, ch in enumerate(text):
        if ch == "'" and not in_double:
            in_single = not in_single
        elif ch == '"' and not in_single:
            in_double = not in_double
        elif (
                ch == "#"
                and not (in_single or in_double)
                and (i == 0 or text[i - 1].isspace())
        ):
            return text[:i].rstrip(), text[i:]
    return text.rstrip(), None


KV = namedtuple("KV", "keycol has_dash key value comment")


def parse_kv(line):
    """
    Return a KV for a scalar `key: value` line (optionally a `- key: value`
    sequence item), else None so the line breaks the current alignment run.
    """
    stripped = line.lstrip(" ")
    keycol = len(line) - len(stripped)
    has_dash = stripped.startswith("- ")
    if has_dash:
        stripped = stripped[2:]
        keycol += 2
    if not stripped or stripped.startswith("#"):
        return None
    code, comment = split_comment(stripped)
    sep = code.find(": ")  # -1 for a block opener `key:` or non-mapping line
    key, value = code[:sep], code[sep + 2:].strip()
    if sep == -1 or not key or not value or ":" in key:
        return None
    return KV(keycol, has_dash, key, value, comment)


def align(text):
    out = []
    run = []  # a run of KVs sharing a keycol, aligned together

    def flush():
        if not run:
            return
        key_width = max(len(entry.key) for entry in run)
        has_comment = any(entry.comment for entry in run)
        value_width = max(len(entry.value) for entry in run) if has_comment else 0
        for entry in run:
            indent = (
                " " * (entry.keycol - 2) + "- "
                if entry.has_dash
                else " " * entry.keycol
            )
            out_line = (
                    indent
                    + (entry.key + ": ").ljust(key_width + 2)
                    + entry.value.ljust(value_width)
            )
            if entry.comment:
                out_line += " " + entry.comment
            out.append(out_line.rstrip())
        run.clear()

    block_indent = None  # set while inside a `|` / `>` block scalar body
    prev_blank = False
    for line in text.split("\n"):
        stripped = line.lstrip(" ")
        lead = len(line) - len(stripped)
        if block_indent is not None:
            if stripped == "" or lead > block_indent:
                out.append(line)  # block body is kept verbatim
                prev_blank = False
                continue
            block_indent = None
        if stripped == "":
            flush()
            if not prev_blank:  # at most one blank line in a row
                out.append("")
            prev_blank = True
            continue
        prev_blank = False
        kv = parse_kv(line)
        if kv is None:
            flush()
            out.append(line)
            continue
        if run and run[0].keycol != kv.keycol:
            flush()
        run.append(kv)
        if kv.value[0] in "|>":  # value opens a block scalar
            flush()
            block_indent = lead
    flush()
    return "\n".join(out)


def parse_docs(text, what):
    try:
        return list(pyyaml.safe_load_all(text))
    except pyyaml.YAMLError as exc:
        raise FormatError(f"{what}: {exc}") from exc


def format_text(text):
    before = parse_docs(text, "invalid YAML")
    if len(before) > 1:
        raise FormatError("multi-document files (`---`) are not supported")
    if all(doc is None for doc in before):
        return text  # empty or comment-only
    result = align(normalize(text))
    after = parse_docs(result, "formatting produced invalid YAML")
    if before != after:
        raise FormatError("formatting altered document semantics")
    return result


def iter_yaml(paths):
    for raw in paths:
        path = Path(raw)
        yield from sorted(path.rglob("*.yaml")) if path.is_dir() else [path]


def format_stdin():
    # Raw byte I/O: keeps LF from becoming CRLF under Windows text mode, and on
    # failure echoes the input back rather than emitting nothing.
    text = sys.stdin.buffer.read().decode("utf-8")
    try:
        out = format_text(text)
        code = 0
    except FormatError as exc:
        sys.stderr.write(f"format: {exc}\n")
        out = text
        code = 1
    sys.stdout.buffer.write(out.encode("utf-8"))
    return code


def main(argv):
    if "--stdin" in argv:
        return format_stdin()
    check = "--check" in argv
    paths = [a for a in argv if a != "--check"] or ["data"]
    changed, errors = [], []
    for path in iter_yaml(paths):
        try:
            original = path.read_text(encoding="utf-8")
            result = format_text(original)
        except FileNotFoundError:
            continue  # deleted/renamed in a changed-files list; nothing to format
        except (OSError, FormatError) as exc:
            print(f"{path}: {exc} -- skipped", file=sys.stderr)
            errors.append(path)
            continue
        if result == original:
            continue
        changed.append(path)
        if check:
            sys.stdout.writelines(
                difflib.unified_diff(
                    original.splitlines(keepends=True),
                    result.splitlines(keepends=True),
                    fromfile=str(path),
                    tofile=f"{path} (formatted)",
                )
            )
        else:
            path.write_text(result, encoding="utf-8", newline="\n")
            print(f"formatted {path}")
    if check and changed:
        print(
            f"\n{len(changed)} file(s) need formatting. Run: python tools/yaml/format.py"
        )
    return 1 if errors or (check and changed) else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
