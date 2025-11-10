#!/bin/bash

any_issues=false

license_headers_output=$(python tools/ci/sanity_checks/detect_license_headers.py 2>&1 || true)
if [[ -n "$license_headers_output" ]]; then
    if ! $any_issues; then
        echo "## :x: General Checks Failed"
        any_issues=true
    fi
    echo "### License Header Errors:"
    echo '```'
    echo "$license_headers_output"
    echo '```'
    echo
fi

price_checker_output=$(python tools/price_checker.py 2>&1 || true)
if [[ -n "$price_checker_output" ]]; then
    if ! $any_issues; then
        echo "## :x: General Checks Failed"
        any_issues=true
    fi
    echo "### Price Checker Errors:"
    echo '```'
    echo "$price_checker_output"
    echo '```'
    echo
fi

if [[ $# -gt 0 ]]; then
    targets=("$@")
    for file in "${targets[@]}"; do
        # Black formatter used for Python violates some of our general rules
        [[ -f $file && $file != *.py ]] || continue

        general_output=$(python tools/ci/sanity_checks/general.py "$file" 2>&1 || true)
    done
else
    general_output=$(python tools/ci/sanity_checks/general.py . 2>&1 || true)
fi

if [[ -n "$general_output" ]]; then
    if ! $any_issues; then
        echo "## :x: General Checks Failed"
        any_issues=true
    fi
    echo "$general_output"
    echo
fi

# If no section was written, emit a success summary
if ! $any_issues; then
    echo "## :heavy_check_mark: General Checks Passed"
    echo
fi

$any_issues && exit 1 || exit 0
