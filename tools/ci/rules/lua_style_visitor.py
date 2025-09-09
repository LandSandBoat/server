import regex
import re

class LuaStyleVisitor:
    """
    Base class for all Lua style check visitors.
    Each visitor should implement the visit(line, context) method.
    The visitor pattern allows modular, maintainable, and extensible style checks.
    Provides helpers for stripping comments and string literals from lines.
    """
    def strip_comments(self, line):
        return line.split('--')[0]

    def strip_strings(self, line):
        quote_regex = regex.compile(r'"(([^\""]+)|(?R))*+"|\'(([^\'\']+)|(?R))*+\'', re.S)
        return regex.sub(quote_regex, "", line)

    def strip_comments_and_strings(self, line):
        return self.strip_strings(self.strip_comments(line))

    def visit(self, line, context):
        raise NotImplementedError("Each visitor must implement the visit method.")
