#!/bin/bash

targets=("$@")
any_issues=false

for file in "${targets[@]}"; do
    [[ -f $file && $file == *.py ]] || continue

    # Run tools and capture output
    pylint_output=$(pylint --errors-only "$file" 2>&1 || true)
    black_output=$(black --check --diff --quiet "$file" 2>&1 || true)

    # Check if there were issues
    if [[ -n "$pylint_output" || "$black_output" == *"would reformat"* ]]; then
        if ! $any_issues; then
            echo "## :x: Python Checks Failed"
            any_issues=true
        fi

        echo "### \`$file\`"
        if [[ -n "$pylint_output" ]]; then
            echo '```'
            echo "$pylint_output"
            echo '```'
            echo
        fi
        if [[ -n "$black_output" ]]; then
            echo '```diff'
            echo "$black_output"
            echo '```'
            echo
        fi
    fi
done

# If no section was written, emit a success summary
if ! $any_issues; then
    echo "## :heavy_check_mark: Python Checks Passed"
    echo
fi

$any_issues && exit 1 || exit 0
