#!/bin/bash

targets=("$@")
any_issues=false

for file in "${targets[@]}"; do
    [[ -f $file && $file == *.sql ]] || continue

    # Run tools and capture output
    bogus_comments=$(grep -En '(--\w)|^(---\s)' "$file" 2>&1 || true)

    # Check if there were issues
    if [[ -n "$bogus_comments" ]]; then
        if ! $any_issues; then
            echo "## :x: SQL Checks Failed"
            any_issues=true
        fi

        echo "### Bogus comments: \`$file\`"
        echo '```'
        echo "$bogus_comments"
        echo '```'
        echo
    fi
done

# If no section was written, emit a success summary
if ! $any_issues; then
    echo "## :heavy_check_mark: SQL Checks Passed"
    echo
fi

$any_issues && exit 1 || exit 0
