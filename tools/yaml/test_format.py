#!/usr/bin/env python3
"""Golden tests for tools/yaml/format.py. Run: python tools/yaml/test_format.py"""

import textwrap

import format as fmt

CASES = {
    "aligns values and comments": (
        """
        values:
          a: 1  # short
          longer_key: 2  # tail
        """,
        """
        values:
          a:          1 # short
          longer_key: 2 # tail
        """,
    ),
    "reindents to two spaces": (
        """
        top:
            deep: 1
            deeper:
                x: 2
        """,
        """
        top:
          deep: 1
          deeper:
            x: 2
        """,
    ),
    "normalizes quotes and flow spacing": (
        """
        v:
          a: 'x'
          b: { m: 1,n: 2 }
        """,
        """
        v:
          a: x
          b: {m: 1, n: 2}
        """,
    ),
    "collapses blank lines, trims trailing ws": (
        "a: 1   \n\n\n\nb: 2\n",
        "a: 1\n\nb: 2\n",
    ),
    "leaves block scalar bodies verbatim": (
        """
        s:
          body: |
            keep:  spacing

            and blanks
          n: 3
        """,
        """
        s:
          body: |
            keep:  spacing

            and blanks
          n: 3
        """,
    ),
    "keeps null-valued keys": (
        """
        item:
          name: a
          alias: null
          empty:
          count: 3
        """,
        """
        item:
          name:  a
          alias: null
          empty: null
          count: 3
        """,
    ),
    "aligns dash-line sequence keys": (
        """
        items:
          - id: 1
            name: a
          - id: 2
            name: bb
        """,
        """
        items:
          - id:   1
            name: a
          - id:   2
            name: bb
        """,
    ),
}


def dedent(block):
    return textwrap.dedent(block).lstrip("\n")


def main():
    failures = 0
    for name, (raw, expected) in CASES.items():
        got = fmt.format_text(dedent(raw))
        want = dedent(expected)
        if got == want:
            print(f"  ok   {name}")

        else:
            failures += 1
            print(f"  FAIL {name}")
            print(f"    expected:\n{want!r}")
            print(f"    got:\n{got!r}")

    # idempotency: formatting the output again is a fixed point
    for name, (_, expected) in CASES.items():
        want = dedent(expected)
        if fmt.format_text(want) != want:
            failures += 1
            print(f"  FAIL not idempotent: {name}")

    # multi-document is refused, not crashed
    try:
        fmt.format_text("a: 1\n---\nb: 2\n")
        failures += 1
        print("  FAIL multi-doc should raise FormatError")

    except fmt.FormatError:
        print("  ok   multi-doc refused")

    # empty / comment-only / explicit-null files are left untouched, not corrupted
    for label, text in [
        ("empty", ""),
        ("comment-only", "# just a header comment\n"),
        ("explicit null", "~\n"),
    ]:
        if fmt.format_text(text) == text:
            print(f"  ok   {label} left as-is")

        else:
            failures += 1
            print(f"  FAIL {label} was rewritten to {fmt.format_text(text)!r}")

    print(f"\n{'PASS' if not failures else f'{failures} FAILURE(S)'}")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
