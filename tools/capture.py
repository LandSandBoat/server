#!/usr/bin/env python3
"""Capture a Tracy trace from a running server, auto-named by timestamp.

Thin wrapper around tracy-capture(.exe). Writes the trace to a file named
trace_<year>_<month>_<day>_<hour>_<minute>_<second>.tracy, then extracts a CSV of
zone statistics next to it with the same base name (via tracy-csvexport).

Equivalent to:
    tracy-capture(.exe) -o <stamp>.tracy -f -s <seconds> -p <port>
    tracy-csvexport(.exe) <stamp>.tracy > <stamp>.csv

Examples:
    python ./tools/capture.py
    ./tools/capture.py --seconds 120 --out-dir traces
    ./tools/capture.py --port 8087     # capture a process running TRACY_PORT=8087
    ./tools/capture.py --self          # self-times CSV (tracy-csvexport -e)
    ./tools/capture.py --no-csv        # capture only, skip extraction
"""

import argparse
import datetime as dt
import subprocess
import sys
from pathlib import Path


def find_tool(repo_root: Path, name: str) -> Path | None:
    """Locate a Tracy tool at the repo root, with or without the .exe suffix."""
    for candidate in (repo_root / f"{name}.exe", repo_root / name):
        if candidate.exists():
            return candidate
    return None


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "-s",
        "--seconds",
        type=int,
        default=60,
        help="Capture duration in seconds (tracy-capture -s). Default: 60.",
    )
    parser.add_argument(
        "-p",
        "--port",
        type=int,
        default=8086,
        help="Port to connect to (tracy-capture -p), matching the profiled "
        "process's TRACY_PORT. Default: 8086.",
    )
    parser.add_argument(
        "-o",
        "--out-dir",
        type=Path,
        default=Path.cwd(),
        help="Directory to write the trace (and CSV) into. Default: current directory.",
    )
    parser.add_argument(
        "--self",
        dest="self_times",
        action="store_true",
        help="Export self-times (tracy-csvexport -e) instead of inclusive totals.",
    )
    parser.add_argument(
        "--no-csv",
        dest="csv",
        action="store_false",
        help="Capture the trace only; skip the CSV extraction.",
    )
    args = parser.parse_args()

    # tracy tools live at the repo root, one level up from tools/.
    repo_root = Path(__file__).resolve().parent.parent
    capture = find_tool(repo_root, "tracy-capture")
    if capture is None:
        print(f"error: tracy-capture(.exe) not found in {repo_root}", file=sys.stderr)
        return 1

    args.out_dir.mkdir(parents=True, exist_ok=True)
    stamp = dt.datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
    trace_file = args.out_dir / f"trace_{stamp}.tracy"

    # -f: overwrite if it exists, -s: capture duration in seconds, -p: data port
    print(f"Capturing {args.seconds}s on port {args.port} -> {trace_file}")
    rc = subprocess.run(
        [str(capture), "-o", str(trace_file), "-f",
         "-s", str(args.seconds), "-p", str(args.port)]
    ).returncode
    if rc != 0:
        return rc

    if not args.csv:
        return 0

    csvexport = find_tool(repo_root, "tracy-csvexport")
    if csvexport is None:
        print(
            f"warning: tracy-csvexport(.exe) not found in {repo_root}; skipping CSV",
            file=sys.stderr,
        )
        return 0

    csv_file = trace_file.with_suffix(".csv")
    cmd = [str(csvexport)]
    if args.self_times:
        cmd.append("-e")
    cmd.append(str(trace_file))

    print(f"Trace: {trace_file}")
    print(f"CSV: {csv_file}")

    with open(csv_file, "wb") as out:
        return subprocess.run(cmd, stdout=out).returncode


if __name__ == "__main__":
    sys.exit(main())
