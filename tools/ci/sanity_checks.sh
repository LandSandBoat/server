#!/bin/bash
set -uo pipefail

checks_failed=false

OUTPUT="sanity_checks_summary.md"
echo "# Sanity Check Results" > "$OUTPUT"

run_check() {
    echo "Running $1..."
    bash "$1" "${@:2}" | tee -a "$OUTPUT"
    [[ $? -ne 0 ]] && checks_failed=true
}

if [[ $# -gt 0 ]]; then
    GIT_REF="$1"
    echo "Changed files:"
    git diff --name-status "$GIT_REF.."
    git diff --name-only "$GIT_REF.." > changed-files.txt
    readarray -t CHANGED_FILES < changed-files.txt
    CHANGED_FILES="${CHANGED_FILES[@]}"

    # Git
    echo "Checking commit formatting..."
    gitcheck_output=$(python tools/ci/sanity_checks/git.py $GIT_REF 2>&1 || true)
    if [[ -n "$gitcheck_output" ]]; then
        checks_failed=true
        {
            echo "## :x: Git Checks Failed"
            echo "$gitcheck_output"
            echo
        } | tee -a "$OUTPUT"
    else
        {
            echo "## :heavy_check_mark: Git Checks Passed"
            echo
        } | tee -a "$OUTPUT"
    fi
fi

# General
run_check tools/ci/sanity_checks/general.sh "${CHANGED_FILES[@]}"

# Python
run_check tools/ci/sanity_checks/python.sh "${CHANGED_FILES[@]}"

# SQL
run_check tools/ci/sanity_checks/sql.sh "${CHANGED_FILES[@]}"

# Lua
python tools/ci/sanity_checks/lua_stylecheck.py test | tee -a "$OUTPUT"
run_check tools/ci/sanity_checks/lua.sh "${CHANGED_FILES[@]}"

# C++
run_check tools/ci/sanity_checks/cpp.sh "${CHANGED_FILES[@]}"

if [[ "$checks_failed" == "true" ]]; then
    echo "One or more checks failed."
    exit 1
else
    echo "All checks passed."
    exit 0
fi
