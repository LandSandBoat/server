#!/bin/bash

# Requires the following packages:
# cppcheck

any_issues=false

if [[ $# -gt 0 ]]; then
    targets=("$@")
else
    mapfile -t targets < <(find src -name '*.cpp' -o -name '*.h')
fi

for file in "${targets[@]}"; do
    [[ -f $file && $file == *.cpp || $file == *.h ]] || continue

    # Run tools and capture output
    if [[ $file == *.cpp ]]; then
        # --enable=performance
        # Enable additional checks. The available ids are:
        # all - Enable all checks
        # style - Check coding style
        # performance - Enable performance messages
        # portability - Enable portability messages
        # information - Enable information messages
        # unusedFunction - Check for unused functions
        # missingInclude - Warn if there are missing includes. For detailed information use --check-config
        # Several ids can be given if you separate them with commas, e.g. --enable=style,unusedFunction. See also --std

        # --suppress=passedByValue:src/map/packet_system.cpp
        # The compiler produces the same assembly for passByValue, std::move and
        # passByConstRef here, so we can silence this warning.
        # https://quick-bench.com/q/13EX97WSfj9-rY_98opaAwgDOQc

        cppcheck_output=$(cppcheck -v -j 4 --force --quiet --inconclusive --std=c++17 \
        --suppress=passedByValue:src/map/packet_system.cpp \
        --suppress=unmatchedSuppression \
        --suppress=missingIncludeSystem \
        --suppress=missingInclude \
        --suppress=checkersReport \
        --enable=information,performance,portability,missingInclude --inline-suppr \
        --inconclusive \
        -DSA_INTERRUPT -DZMQ_DEPRECATED -DZMQ_EVENT_MONITOR_STOPPED -DTRACY_ENABLE \
        "$file" 2>&1 || true)

        cpppy_output=$(python tools/ci/sanity_checks/cpp.py "$file" 2>&1 || true)

        # Check if there were issues
        if [[ -n "$cppcheck_output" || -n "$cpppy_output" ]]; then
            if ! $any_issues; then
                echo "## :x: C++ Checks Failed"
                any_issues=true
            fi

            if [[ -n "$cppcheck_output" ]]; then
                echo "#### Cppcheck Errors:"
                echo "> $file"
                echo '```'
                echo "$cppcheck_output"
                echo '```'
            fi
            if [[ -n "$cpppy_output" ]]; then
                echo "$cpppy_output"
            fi
            echo
        fi
    fi
    clang-format -style=file -i "$file"
done

git_diff_output=$(git diff --no-color 2>&1 || true)

if [[ -n "$git_diff_output" ]]; then
    if ! $any_issues; then
        echo "## :x: C++ Checks Failed"
        any_issues=true
    fi
    echo "#### Formatting Errors:"
    echo "> $(clang-format -version)"
    echo '```diff'
    echo "$git_diff_output"
    echo '```'
    echo
fi

if ! $any_issues; then
    echo "## :heavy_check_mark: C++ Checks Passed"
    echo
fi

$any_issues && exit 1 || exit 0
