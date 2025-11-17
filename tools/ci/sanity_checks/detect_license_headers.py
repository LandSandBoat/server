# Detect if all source files have the correct GPLv3 header.

import os
import sys

excluded_files = [
    "./src/common/version.cpp",  # Auto-generated
    "./src/common/WheatyExceptionReport.cpp",  # Not ours
    "./src/common/WheatyExceptionReport.h",  # Not ours
]


def check_header(filename):
    for excluded_file in excluded_files:
        if os.path.normpath(filename) == os.path.normpath(excluded_file):
            return True

    with open(filename, "r") as f:
        file_content = f.readlines()

        found_gpl = False
        found_v3 = False

        for line in file_content[:20]:
            line = line.lower()

            if "gnu general public license" in line:
                found_gpl = True

            if "version 3" in line:
                found_v3 = True

            # Incompatible license
            if "gnu affero general public license" in line:
                print("Incompatible license in file: " + filename)
                return False

        if found_gpl and found_v3:
            return True

    return False


def main():
    bad_headers = False
    for root, _, files in os.walk("./src"):
        for file in files:
            if file.endswith(".h") or file.endswith(".cpp"):
                file = os.path.join(root, file)
                if not check_header(file):
                    print("Incorrect header in file: " + file)
                    bad_headers = True


if __name__ == "__main__":
    main()
