# This script will detect and replace the byte-order-mark for a file.
# https://en.wikipedia.org/wiki/Byte_order_mark
#
# If the BOM is accidentally set to something we aren't expecting; it's
# hard to detect, and it can break the file for people using extended
# language sets (Japanese etc.).
#
# Modes:
# 0: Try to remove all BOMs
# 1: Try to use only UTF-8 BOM
#
# Usage: python bom_checker.py <file or dir> <mode (defaults to 0)>
# Example (Remove BOMs): python .\tools\bom_checker.py .\src 0
# Example (Add BOMs): python .\tools\bom_checker.py .\src 1

import os
import sys

files_to_convert = []


def detect_bom(filename, mode):
    with open(filename, "rb") as file:

        invalid = ""

        beginning = file.read(4)
        # The order of these if-statements is important
        # otherwise UTF32 LE may be detected as UTF16 LE as well
        # Comment out your desired configuration
        if beginning == b"\x00\x00\xfe\xff":
            invalid = "UTF-32 BE: " + filename
        elif beginning == b"\xff\xfe\x00\x00":
            invalid = "UTF-32 LE: " + filename
        elif beginning[0:3] == b"\xef\xbb\xbf" and mode == 0:
            invalid = "UTF-8: " + filename
        elif beginning[0:2] == b"\xff\xfe":
            invalid = "UTF-16 LE: " + filename
        elif beginning[0:2] == b"\xfe\xff":
            invalid = "UTF-16 BE: " + filename
        elif mode == 1:
            invalid = "Unknown or no BOM: " + filename

        if invalid != "":
            print(invalid)
            files_to_convert.append(filename)


def detect_files(target, mode):
    if os.path.isfile(target):
        detect_bom(target, mode)
    else:
        for path, _, files in os.walk(target):
            for file in files:
                detect_bom(os.path.join(path, file), mode)


def main():
    mode = 0
    if len(sys.argv) > 2:
        mode = int(sys.argv[2])

    if len(sys.argv) > 1:
        detect_files(sys.argv[1], mode)
    else:
        print("Usage: python bom_checker.py <file or dir>")
        exit(-1)

    if len(files_to_convert) > 0:
        from_enc = "utf-8-sig"
        to_enc = "utf-8"
        if mode == 1:
            from_enc = "utf-8"
            to_enc = "utf-8-sig"

        if mode == 0:
            print(f"Removing BOM from {len(files_to_convert)} marked files")
        else:
            print(f"Adding UTF-8 BOM from {len(files_to_convert)} marked files")

        for filename in files_to_convert:
            str = ""

            with open(filename, mode="r", encoding=from_enc) as file:
                str = file.read()

            with open(filename, mode="w", encoding=to_enc) as file:
                file.write(str)

        print("Done!")
        print(
            "If you're seeing this in CI, you need to run this script locally and push your modified files to your PR!"
        )


if __name__ == "__main__":
    main()
