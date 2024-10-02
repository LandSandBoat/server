#
# Run from repo root!
#

# Capture argument as target file
target=$1

# Ensure we have clang-format
if ! [ -x "$(command -v clang-format)" ]; then
    echo 'Error: clang-format is not installed.' >&2
    exit 1
fi

# Ensure clang-format major version is exactly 18
if ! clang-format --version | grep -q "version 18"; then
    echo 'Error: clang-format version 18 is required.' >&2
    echo 'Found:' $(clang-format --version) >&2
    exit 1
fi

if [ -z "$target" ]; then
    # Run clang-format on src and modules folders
    for f in $(find src/ -name '*.h' -or -name '*.cpp'); do clang-format -style=file -i $f; done
    for f in $(find modules/ -name '*.h' -or -name '*.cpp'); do clang-format -style=file -i $f; done
elif [ -f "$target" ]; then
    clang-format -style=file -i $target
fi

exit 0
