#!/bin/bash
set -uo pipefail

OUTPUT="sanity_checks_summary.md"
rm -f "$OUTPUT"
OUTPUT_TEMP="sanity_checks_temp.md"
OUTPUT_FAILED="sanity_checks_failed.md"
echo > "$OUTPUT_FAILED"
# https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-collapsed-sections
# create collapsed success section
echo "<details><summary>Passed tests (click to expand)</summary>" >> "$OUTPUT"
# blank line is necessary for first line to have markdown
echo >> "$OUTPUT"

run_check() {
    echo "Running $1..."
    echo > "$OUTPUT_TEMP"
    bash "$1" "${@:2}" | tee -a "$OUTPUT_TEMP"
    if [[ $? -ne 0 ]]; then
        cat "$OUTPUT_TEMP" >> "$OUTPUT_FAILED"
    else
        cat "$OUTPUT_TEMP" >> "$OUTPUT"
    fi
}

if [[ $# -gt 0 ]]; then
    GIT_REF="$1"
    echo "Changed files:"
    git diff --name-status "$GIT_REF.."
    git diff --name-only "$GIT_REF.." > changed-files.txt
    readarray -t CHANGED_FILES < changed-files.txt

    # Git
    echo "Checking commit formatting..."
    gitcheck_output=$(python tools/ci/sanity_checks/git.py $GIT_REF 2>&1 || true)
    if [[ -n "$gitcheck_output" ]]; then
        {
            echo "## :x: Git Checks Failed"
            echo "$gitcheck_output"
            echo
        } | tee -a "$OUTPUT_FAILED"
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
# lua_stylecheck.py only outputs errors
echo "Running tools/ci/sanity_checks/lua_stylecheck.py unit tests..."
python tools/ci/sanity_checks/lua_stylecheck.py test | tee -a "$OUTPUT_FAILED"
run_check tools/ci/sanity_checks/lua.sh "${CHANGED_FILES[@]}"

# C++
run_check tools/ci/sanity_checks/cpp.sh "${CHANGED_FILES[@]}"

# end collapsed "passed tests" section
echo "</details>" >> "$OUTPUT"
# blank line is necessary for collapsing to work properly
echo >> "$OUTPUT"

# Failure is determined by any non-trivial lines in the $OUTPUT_FAILED file
if [[ $(grep -v "^$" "$OUTPUT_FAILED" | wc -l) -gt 0 ]]; then
    echo "One or more checks failed."

    cat "$OUTPUT_FAILED" >> "$OUTPUT"
    exit 1
else
    echo "## :heavy_check_mark: All sanity checks passed" | tee -a "$OUTPUT"
    exit 0
fi
