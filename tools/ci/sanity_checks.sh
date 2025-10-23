#!/bin/bash
set -uo pipefail

checks_failed=false
GIT_REF="${GIT_REF:-origin/base}"
OUTPUT="sanity_checks_summary.md"
echo "# Sanity Check Results" > "$OUTPUT"

echo "Changed files:"
git diff --name-status "$GIT_REF.."
git diff --name-only "$GIT_REF.." > changed-files.txt
readarray -t CHANGED_FILES < changed-files.txt
CHANGED_FILES="${CHANGED_FILES[@]}"

run_check() {
    echo "Running $1..."
    bash "$1" "${@:2}" >> "$OUTPUT"
    [[ $? -ne 0 ]] && checks_failed=true
}

# Git
echo "Checking commit formatting..."
gitcheck_output=$(python tools/ci/sanity_checks/git.py $GIT_REF 2>&1 || true)
if [[ -n "$gitcheck_output" ]]; then
    checks_failed=true
    {
        echo "## :x: Git Checks Failed"
        echo "$gitcheck_output"
        echo
    } >> "$OUTPUT"
else
    {
        echo "## :heavy_check_mark: Git Checks Passed"
        echo
    } >> "$OUTPUT"
fi

# License Headers
echo "Checking license headers..."
license_headers_output=$(python tools/ci/sanity_checks/detect_license_headers.py 2>&1 || true)
if [[ -n "$license_headers_output" ]]; then
    checks_failed=true
    {
        echo "## :x: License Headers Checks Failed"
        echo '```'
        echo "$license_headers_output"
        echo '```'
        echo
    } >> "$OUTPUT"
else
    {
        echo "## :heavy_check_mark: License Headers Checks Passed"
        echo
    } >> "$OUTPUT"
fi

# General
run_check tools/ci/sanity_checks/general.sh "${CHANGED_FILES[@]}"

# Python
run_check tools/ci/sanity_checks/python.sh "${CHANGED_FILES[@]}"

# SQL
run_check tools/ci/sanity_checks/sql.sh "${CHANGED_FILES[@]}"

# Lua
python tools/ci/sanity_checks/lua_stylecheck.py test >> "$OUTPUT"
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
