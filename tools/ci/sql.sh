#!/bin/bash

target=${1:-sql}

file_list=()

if [[ -d ${target} ]]
then
    for f in ${target}/*.sql; do
        file_list+=("${f}")
    done
else
    file_list+=(${target})
fi

check_mod_comments() {
python3 << EOF
filename = '$1'

with open(filename) as f:
    lines = f.readlines()
    for line in lines:
        line = line.strip()
        if not line.startswith("-- ") and not "--" in line:
            print(line)
EOF
}

for f in "${file_list[@]}"
do
    BOGUS_COMMENTS=`grep -En '(--\w)' $f`
    if [[ -n $BOGUS_COMMENTS ]]; then
        printf "Bogus comments: $f:\n"
        printf "%s\n" "${BOGUS_COMMENTS[@]}"
    fi

    if [ "$f" = "sql/item_mods.sql" ]; then
        check_mod_comments $f
    fi
done
