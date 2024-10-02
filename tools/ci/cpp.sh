#!/bin/bash

# Requires the following packages:
# cppcheck

# TODO: Use --project=compile_commands.json for the -src option
target=${1:-src}

# --enable=performance
# Enable additional checks. The available ids are:
# all - Enable all checks
# style - Check coding style
# performance - Enable performance messages
# portability - Enable portability messages
# information - Enable information messages
# unusedFunction - Check for unused functions
# missingInclude - Warn if there are missing includes. For detailed information use --check-config
# Several ids can be given if you separate them with commas, e.g. --enable=style,unusedFunction. See also --std

# --suppress=passedByValue:src/map/packet_system.cpp
# The compiler produces the same assembly for passByValue, std::move and
# passByConstRef here, so we can silence this warning.
# https://quick-bench.com/q/13EX97WSfj9-rY_98opaAwgDOQc

cppcheck -v -j 4 --force --quiet --inconclusive --std=c++17 \
--enable=performance,portability \
--inline-suppr \
--suppress=passedByValue:src/map/packet_system.cpp \
--suppress=unmatchedSuppression \
--suppress=missingInclude \
--suppress=missingIncludeSystem \
--suppress=checkersReport \
--check-level=exhaustive \
--inconclusive \
-DSA_INTERRUPT -DZMQ_DEPRECATED -DZMQ_EVENT_MONITOR_STOPPED -DTRACY_ENABLE \
${target}

python3 << EOF
import glob
import os

target = '${target}'

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
    return "#include \"../" in line

def load_documented_events(file_path):
    with open(file_path, 'r') as file:
        return {line.split(' - ')[0].strip() for line in file.readlines()}

documented_events = load_documented_events('documentation/AI_Events.txt')

def contains_undocumented_listener(line):
    import re
    match = re.search(r'\.triggerListener\("([^"]+)"', line)
    if match:
        listener = match.group(1)
        return listener not in documented_events
    return False

def check(name):
    if os.path.isfile(name):
        with open(name) as f:
            counter = 0
            for line in f.readlines():
                counter = counter + 1
                if contains_delete(line):
                    print(f"{name}:{counter}: Found naked delete. Please use destroy(ptr) or destroy_arr(ptr).")
                    print(line)
                if contains_relative_include(line):
                    print(f"{name}:{counter}: Found relative include. Please use non-relative paths.")
                    print(line)
                if contains_undocumented_listener(line):
                    print(f"{name}:{counter}: Found undocumented listener. Please document this in AI_Events.txt.")
                    print(line)

if target == 'src':
    for filename in glob.iglob('src/**/*.cpp', recursive=True):
        check(filename)
    for filename in glob.iglob('src/**/*.h', recursive=True):
        check(filename)
else:
    check(target)
EOF
