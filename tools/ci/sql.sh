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

FAIL=0
printf "Checking for bogus comments:"
for f in "${file_list[@]}"
do
    BOGUS_COMMENTS=`grep -En '(--\w)' $f`
    if [[ -n $BOGUS_COMMENTS ]]; then
        printf "\n$f:\n"
        printf "%s\n" "${BOGUS_COMMENTS[@]}"

        FAIL=1
    fi
done

if [ ${FAIL} == 1 ]; then
    exit 1
fi
