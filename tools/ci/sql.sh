#!/bin/bash

target=${1:-sql}
printf "Target: %s\n" ${target}

file_list=()

if [[ -d ${target} ]]
then
    for f in ${target}/*.sql; do
        file_list+=("${f}")
    done
else
    file_list+=(${target})
fi

#for f in "${file_list[@]}"
#do
    # TODO: Use a mysql executable to validate the sql scripts
#done
