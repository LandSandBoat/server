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

for f in "${file_list[@]}"
do
    BOGUS_COMMENTS=`grep -En '(--\w)|^(---\s)' $f`
    if [[ -n $BOGUS_COMMENTS ]]; then
        printf "Bogus comments: $f:\n"
        printf "%s\n" "${BOGUS_COMMENTS[@]}"
    fi
done
