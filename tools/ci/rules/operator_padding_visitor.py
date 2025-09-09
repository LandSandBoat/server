from .lua_style_visitor import LuaStyleVisitor
import regex
import re

class OperatorPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for operator and comparator padding checks.
    Ensures operators/comparators have one space before and after, and no excessive padding.
    Ignores operators inside comments and string literals.
    """
    def visit(self, line, context):
        for _ in re.finditer(r"[^ =~\<\>][\=\+\*\~/\><]|[\=\+\*/\><][^ =\n]", context.line_no_comments_or_strings):
            context.error("Operator or comparator without padding detected at end of line")
        stripped_line = context.line_no_comments_or_strings.lstrip()
        brace_regex = regex.compile(r"\{(([^\}\{]+)|(?R))*+\}", re.S)
        stripped_line = regex.sub(brace_regex, "", stripped_line)
        for _ in re.finditer(r"\s{2,}(>=|<=|==|~=|\+|\*|%|>|<|\^)|(>=|<=|==|~=|\+|\*|%|>|<|\^)\s{2,}", stripped_line):
            context.error("Excessive padding detected around operator or comparator.")
