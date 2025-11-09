#!/usr/bin/env python3
"""
Run clang-format on C++ source files.

Usage: python3 tools/run_clang_format.py [--check]
  --check : Only check formatting without modifying files
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path


def find_clang_format():
    """Find clang-format executable."""
    # Check paths for clang-format-20 only
    paths = [
        "clang-format-20",
        "/usr/bin/clang-format-20",
        "/usr/local/bin/clang-format-20",
        "/opt/homebrew/bin/clang-format-20",
        "clang-format",
        "/usr/bin/clang-format",
        "/usr/local/bin/clang-format",
        "/opt/homebrew/bin/clang-format",
    ]

    for path in paths:
        executable = shutil.which(path) if "/" not in path else path
        if executable and os.path.isfile(executable):
            try:
                # Verify it's exactly version 20
                result = subprocess.run(
                    [executable, "--version"], capture_output=True, text=True, timeout=5
                )
                if result.returncode == 0:
                    # Extract version number from output like "clang-format version 20.0.0"
                    import re

                    version_match = re.search(r"version (\d+)\.", result.stdout)
                    if version_match:
                        major_version = int(version_match.group(1))
                        if major_version == 20:
                            return executable
            except:
                continue

    print("Error: clang-format version 20 not found!")
    sys.exit(1)


def find_source_files():
    """Find all C++ source files in src/ and modules/ directories."""
    files = []
    for directory in ["src", "modules"]:
        if os.path.exists(directory):
            for ext in ["*.cpp", "*.h"]:
                files.extend(Path(directory).rglob(ext))
    return sorted(files)


def main():
    check_only = "--check" in sys.argv

    clang_format = find_clang_format()
    print(f"Using: {clang_format}")

    if not os.path.isfile(".clang-format"):
        print("Error: Run from repository root (where .clang-format exists)")
        sys.exit(1)

    files = find_source_files()
    print(f"Processing {len(files)} files...")

    failed = 0
    for file_path in files:
        if check_only:
            cmd = [
                clang_format,
                "--style=file",
                "--dry-run",
                "--Werror",
                str(file_path),
            ]
        else:
            cmd = [clang_format, "--style=file", "-i", str(file_path)]

        result = subprocess.run(cmd, capture_output=True)
        if result.returncode != 0:
            failed += 1
            print(f"Failed: {file_path}")

    if failed == 0:
        print("All files are properly formatted.")
    else:
        print(f"{failed} files failed formatting check.")
        sys.exit(1)


if __name__ == "__main__":
    main()
