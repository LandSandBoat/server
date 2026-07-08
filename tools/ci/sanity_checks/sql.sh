#!/bin/bash

any_issues=false

if [[ $# -gt 0 ]]; then
    targets=("$@")
else
    mapfile -t targets < <(find sql modules -name '*.sql')
fi

for file in "${targets[@]}"; do
    [[ -f $file && ($file == sql/*.sql || $file == modules/**/*.sql) ]] || continue

    # Run tools and capture output
    bogus_comments=$(grep -En '(--\w)|^(---\s)' "$file" 2>&1 || true)

    # Check if there were issues
    if [[ -n "$bogus_comments" ]]; then
        if ! $any_issues; then
            echo "## :x: SQL Checks Failed"
            any_issues=true
        fi

        echo "#### Bogus comments:"
        echo "> $file"
        echo '```'
        echo "$bogus_comments"
        echo '```'
        echo
    fi
done

$any_issues && exit 1 || exit 0
