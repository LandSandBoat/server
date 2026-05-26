import glob
import os
import sys

target = sys.argv[1]


def contains_delete(line):
    if "// cpp.sh allow" in line:
        return False

    if "void operator delete" in line:
        return False

    if "//" in line:
        line = line.split("//")[0]

    if "*" in line:
        line = line.split("*")[0]

    line = line.strip()
    if line.startswith("Show"):
        return False

    return "delete " in line or "delete[]" in line or "delete []" in line


def contains_relative_include(line):
    return '#include "../' in line


def load_documented_events(file_path):
    with open(file_path, "r") as file:
        return {line.split(" - ")[0].strip() for line in file.readlines()}


documented_events = load_documented_events("documentation/AI_Events.txt")


def contains_undocumented_listener(line):
    import re

    match = re.search(r'\.triggerListener\("([^"]+)"', line)
    if match:
        listener = match.group(1)
        return listener not in documented_events
    return False


def tracy_missing_blank_line(lines, i):
    if lines[i].strip() != "TracyZoneScoped;":
        return False
    if i + 1 >= len(lines):
        return False
    next_line = lines[i + 1].strip()
    return next_line != "" and next_line != "}" and not next_line.startswith("Tracy")


def check(name):
    if os.path.isfile(name):
        with open(name) as f:
            counter = 0
            lines = f.readlines()
            for line in lines:
                counter = counter + 1
                if contains_delete(line):
                    print(
                        f"#### Found naked delete. Please use destroy(ptr) or destroy_arr(ptr).\n> {name}:{counter}"
                    )
                    print(f"```cpp\n{line}\n```\n")
                if contains_relative_include(line):
                    print(
                        f"#### Found relative include. Please use non-relative paths.\n> {name}:{counter}"
                    )
                    print(f"```cpp\n{line}\n```\n")
                if contains_undocumented_listener(line):
                    print(
                        f"#### Found undocumented listener. Please document this in AI_Events.txt.\n> {name}:{counter}"
                    )
                    print(f"```cpp\n{line}\n```\n")
                if tracy_missing_blank_line(lines, counter - 1):
                    print(
                        f"#### TracyZoneScoped; must be followed by a blank line.\n> {name}:{counter}"
                    )
                    print(f"```cpp\n{line}\n```\n")


if target == "src":
    for filename in glob.iglob("src/**/*.cpp", recursive=True):
        check(filename)
    for filename in glob.iglob("src/**/*.h", recursive=True):
        check(filename)
else:
    check(target)
