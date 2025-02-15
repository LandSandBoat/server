# Run from repo root

import os
import subprocess
import sys

# Set exe
CLANG_FORMAT = os.path.join("tools", "clang-format.exe")

# If a filename is provided use that, otherwise try and format the whole src and modules directories
target = None
if len(sys.argv) > 1:
    target = sys.argv[1]

    if not os.path.exists(target):
        print(f"Error: {target} not found")
        sys.exit(1)

if not target:
    print("No target provided, formatting all files in src/ and modules/")
    target = "all"

# Check if clang-format exists
if not os.path.exists(CLANG_FORMAT):
    print("clang-format not found in tools directory, looking in PATH"),
    try:
        result = subprocess.run(
            ["clang-format", "--version"], capture_output=True, text=True, check=True
        )
        print("Found clang-format in PATH")
        CLANG_FORMAT = "clang-format"
    except subprocess.CalledProcessError as e:
        print(f"Error running clang-format: {e}")
        sys.exit(1)

# Ensure we're using clang-format-19
print("Checking clang-format version...")
try:
    result = subprocess.run(
        [CLANG_FORMAT, "--version"], capture_output=True, text=True, check=True
    )
    CLANG_FORMAT_VERSION = result.stdout.strip()
    if "version 19" not in CLANG_FORMAT_VERSION:
        print(
            f"Error: clang-format version 19.x.x is required (got: {CLANG_FORMAT_VERSION})"
        )
        sys.exit(1)
except subprocess.CalledProcessError as e:
    print(f"Error running clang-format: {e}")
    sys.exit(1)

# Format files in src/ and modules/ directories
if target == "all":
    print("Formatting src/ files...")
    for root, _, files in os.walk("src"):
        for file in files:
            if file.endswith(".h") or file.endswith(".cpp"):
                filename = os.path.join(root, file)
                print(f"Formatting {filename}")
                subprocess.run([CLANG_FORMAT, "-style=file", "-i", filename])

    print("Formatting modules/ files...")
    for root, _, files in os.walk("modules"):
        for file in files:
            if file.endswith(".h") or file.endswith(".cpp"):
                filename = os.path.join(root, file)
                print(f"Formatting {filename}")
                subprocess.run([CLANG_FORMAT, "-style=file", "-i", filename])
else:  # Format single file
    print(f"Formatting {target}")
    subprocess.run([CLANG_FORMAT, "-style=file", "-i", target])

print("Done!")
