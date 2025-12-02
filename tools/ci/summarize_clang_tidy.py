import re
import sys
from collections import defaultdict


def parse_tidy_log(log_content):
    warning_regex = re.compile(r"^(/.+?):(\d+):(\d+):\s+warning:\s+(.*)$")
    warnings_by_file = defaultdict(list)
    lines = log_content.splitlines()

    i = 0
    while i < len(lines):
        line = lines[i]
        match = warning_regex.match(line)

        if not match:
            i += 1
            continue

        file_path, line_num, col_num, message = match.groups()

        # Filter '_deps' output
        if "_deps/" in file_path:
            i += 1
            continue

        location = f"{file_path}:{line_num}:{col_num}"
        warning_details = []

        # Look ahead to gather the code snippet and suggestion lines.
        j = i + 1
        while (
            j < len(lines)
            and not warning_regex.match(lines[j])
            and not lines[j].startswith("[")
        ):
            warning_details.append(lines[j])
            j += 1

        warnings_by_file[file_path].append(
            {
                "location": location,
                "message": message,
                "details": "\n".join(warning_details),
            }
        )

        i = j

    return warnings_by_file


def generate_markdown_summary(warnings_by_file):
    if not warnings_by_file:
        return ":heavy_check_mark: No warnings."

    all_warnings = [
        warning for f_warnings in warnings_by_file.values() for warning in f_warnings
    ]
    total_warnings = len(all_warnings)

    summary_header = (
        f"### :x: Found {total_warnings} "
        f"Warning{'s' if total_warnings > 1 else ''}\n"
    )

    markdown_parts = [summary_header]

    for file_path in sorted(warnings_by_file.keys()):
        for warning in warnings_by_file[file_path]:
            markdown_parts.append(f"#### {warning['message']}")
            markdown_parts.append(f"> {warning['location']}")

            if warning["details"]:
                markdown_parts.append(f"```cpp\n{warning['details']}\n```")

            markdown_parts.append("")

    return "\n".join(markdown_parts)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        log_file_path = sys.argv[1]
        try:
            with open(log_file_path, "r") as f:
                log_data = f.read()
            parsed_warnings = parse_tidy_log(log_data)
            markdown_summary = generate_markdown_summary(parsed_warnings)
            print(markdown_summary)
            if parsed_warnings:
                sys.exit(1)
        except FileNotFoundError:
            print(f"Error: File not found at {log_file_path}", file=sys.stderr)
            sys.exit(1)
