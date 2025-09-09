from .lua_style_visitor import LuaStyleVisitor
import re

class ParenthesesPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for parentheses padding checks.
    Ensures no excess whitespace inside of parentheses or solely for alignment.
    """
    def visit(self, line, context):
        line_ncns = context.line_no_comments_or_strings
        if len(re.findall(r"\([ ]| [\)]", line_ncns)) > 0:
            if not line_ncns.lstrip(' ')[0] == '(' and not line_ncns.lstrip(' ')[0] == ')':
                print(line_ncns)
                context.error("No excess whitespace inside of parentheses or solely for alignment.")
