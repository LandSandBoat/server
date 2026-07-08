#!/usr/bin/env python3
"""Configure and build the project with the 'default' CMake preset (RelWithDebInfo).

Runs, from the repo root:
    cmake --preset <preset>
    cmake --build --preset <preset> [--target <target>]

(Note: with presets the build directory comes from the preset, so it is
`cmake --build --preset default`, not `cmake --build build --preset default`.)

Examples:
    python ./tools/build.py                 # configure + build everything, RelWithDebInfo
    ./tools/build.py --target xi_map         # just the map server
    ./tools/build.py --preset debug          # Debug instead
    ./tools/build.py --build-only            # skip the configure step
"""

import argparse
import subprocess
import sys
from pathlib import Path


def run(cmd, cwd) -> int:
    print("+ " + " ".join(cmd))
    return subprocess.run(cmd, cwd=cwd).returncode


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "-p",
        "--preset",
        default="default",
        help="CMake preset to configure and build. Default: default.",
    )
    parser.add_argument(
        "-t",
        "--target",
        default=None,
        help="Build a specific target instead of everything (e.g. xi_map).",
    )
    parser.add_argument(
        "--build-only",
        action="store_true",
        help="Skip the configure step and only build.",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent

    if not args.build_only:
        rc = run(["cmake", "--preset", args.preset], repo_root)
        if rc != 0:
            return rc

    build_cmd = ["cmake", "--build", "--preset", args.preset]
    if args.target:
        build_cmd += ["--target", args.target]
    return run(build_cmd, repo_root)


if __name__ == "__main__":
    sys.exit(main())
