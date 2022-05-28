#!/bin/bash

# The following checks are only for single files, not for directories
if [ $# -eq 0 ]; then
    exit 0
fi

target=${1}

python3 << EOF
with open('${target}') as f:
    data = f.read()
    if not data.endswith('\n'):
        print("No newline at end of file: ${target}")
EOF
