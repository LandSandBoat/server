#!/bin/bash

target=${1:-.}

python3 << EOF
import glob

target = '${target}'

def check(name):
    with open(name) as f:
        lines = f.readlines()
        counter = 0
        for data in lines:
            counter = counter + 1
            if not data.endswith('\n'):
                print(f"No newline at end of file: {name}, please add one.")
            if "\t" in data:
                print(f"Found tab character(s) in file: {name}:{counter}, please replace these with 4x spaces.")

if target == '.':
    for filename in glob.iglob('scripts/**/*.lua', recursive=True):
        check(filename)
    for filename in glob.iglob('src/**/*.cpp', recursive=True):
        check(filename)
    for filename in glob.iglob('src/**/*.h', recursive=True):
        check(filename)
    for filename in glob.iglob('sql/**/*.sql', recursive=True):
        check(filename)
else:
    check(target)
EOF
