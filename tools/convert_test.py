# Convert Eden test file to LSB format
import sys
import os
import re


def convert_test_format(content, file_path):
    # Split content into lines (handles all line endings)
    lines = content.splitlines()
    converted_lines = []

    # Extract suite name from file path
    suite_name = os.path.splitext(os.path.basename(file_path))[0]

    # Find the suite definition
    suite_start = -1
    for i, line in enumerate(lines):
        if "---@type TestSuite" in line or "local suite = {}" in line:
            suite_start = i
            break

    if suite_start == -1:
        return content  # No conversion needed

    # Add any code before the suite definition
    for i in range(suite_start):
        converted_lines.append(lines[i])

    # Collect all non-suite code and tests
    non_suite_code = []
    tests = []
    i = suite_start + 1
    inside_test = False

    while i < len(lines):
        line = lines[i].strip()
        # More flexible regex for suite test definitions
        match = re.match(r"suite\s*\['([^']+)'\]\s*=\s*function\(world\)", line)
        if match:
            inside_test = True
            test_name = match.group(1)
            # Find the end of this test function by looking for 'end'
            i += 1
            test_body = []
            block_level = 0
            while i < len(lines):
                current_line = lines[i]
                stripped_line = current_line.strip()

                if (
                    stripped_line.startswith("if ")
                    or stripped_line.startswith("for ")
                    or stripped_line.startswith("while ")
                    or stripped_line.startswith("function")
                ):
                    block_level += 1
                elif stripped_line == "end":
                    if block_level > 0:
                        block_level -= 1
                    else:
                        break

                if (
                    current_line.strip()
                    and "local client, player = world:spawnPlayer()" not in current_line
                ):
                    # Apply enum conversions
                    converted_line = current_line
                    converted_line = converted_line.replace("xi.items.", "xi.item.")
                    converted_line = converted_line.replace(
                        "xi.bcnm.", "xi.battlefield.id."
                    )
                    converted_line = converted_line.replace(
                        "xi.quest.log_id", "xi.questLog"
                    )
                    # Convert zone names to uppercase
                    converted_line = re.sub(
                        r"xi\.zone\.([A-Za-z_]+)",
                        lambda m: f"xi.zone.{m.group(1).upper()}",
                        converted_line,
                    )
                    test_body.append("      " + converted_line)
                i += 1
            tests.append((test_name, test_body))
            inside_test = False
        else:
            # Only collect as non-suite code if not suite-related and not inside a test
            suite_related = (
                line == ""
                or line == "---@type TestSuite"
                or line == "local suite = {}"
                or line == "return suite"
            )
            if not suite_related and not inside_test:
                non_suite_code.append(lines[i])
        i += 1

    # Remove trailing 'end' lines from non_suite_code
    while non_suite_code and non_suite_code[-1].strip() == "end":
        non_suite_code.pop()

    # Add any non-suite code before the describe block, preserving blank lines and indentation
    for code_line in non_suite_code:
        converted_lines.append(code_line)
    if non_suite_code and non_suite_code[-1].strip() != "":
        converted_lines.append("")
    converted_lines.append(f"describe('{suite_name}', function()")
    converted_lines.append("   local client, player")
    converted_lines.append("")
    converted_lines.append("   setup(function()")
    converted_lines.append("      client, player = xi.test.world:spawnPlayer()")
    converted_lines.append("   end)")
    converted_lines.append("")
    for test_name, test_body in tests:
        converted_lines.append(f"   it('{test_name}', function()")
        converted_lines.extend(test_body)
        converted_lines.append("   end)")
        converted_lines.append("")
    converted_lines.append("end)")
    return "\n".join(converted_lines)


def main():
    if len(sys.argv) != 2:
        print("Usage: python convert_test.py <path_to_lua_file>")
        sys.exit(1)
    file_path = sys.argv[1]
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' does not exist.")
        sys.exit(1)
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)
    converted_content = convert_test_format(content, file_path)
    print(converted_content)


if __name__ == "__main__":
    main()
