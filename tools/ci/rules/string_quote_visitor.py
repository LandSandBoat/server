from .lua_style_visitor import LuaStyleVisitor
import re

class StringQuoteVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        code_line = line.split('--')[0]
        # Only flag strings that are wrapped in double quotes, not double quotes inside single-quoted strings
        # This matches double-quoted strings that are not inside single-quoted strings
        # Example: "this is a string" (should be flagged), but 'Player named "%s" not found!' (should not)
        # We'll use a regex that matches double-quoted strings not preceded by a single quote
        matches = re.finditer(r'(?<!)"([^"\\]|\\.)*"', code_line)
        for match in matches:
            # Check if the match is not inside a single-quoted string
            before = code_line[:match.start()]
            if before.count("'") % 2 == 0:
                context.error("Strings should only be contained by single quotes")
