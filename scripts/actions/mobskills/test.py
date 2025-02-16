#!/usr/bin/env python3
import os
import re


def main():
    folder = "."  # <-- Change this if you want a different folder
    pattern = re.compile(r"\bdmgmod\b")  # Regex to match exact words

    for filename in os.listdir(folder):
        # Skip non-files or files that don't end with .lua (adjust as needed)
        if not filename.endswith(".lua"):
            continue

        filepath = os.path.join(folder, filename)

        # Read file contents
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()

        # Check if file contains the target string
        if "xi.mobskills.mobPhysicalMove" in content:
            # Perform the replacement
            new_content = pattern.sub("ftp", content)

            # Only write if there's an actual change
            if new_content != content:
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(new_content)
                print(f"Modified: {filename}")

    print("Done.")


if __name__ == "__main__":
    main()
