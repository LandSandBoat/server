from .lua_style_visitor import LuaStyleVisitor
import re

class NoFunctionDeclPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for no padding between function keyword and opening parenthesis.
    Ensures no padding occurs between function keyword and opening parenthesis.
    """
    def visit(self, line, context):
        if re.search(r"function\s+\w+\s+\(", context.line_no_comments_or_strings) or re.search(r"function\s+\(", context.line_no_comments_or_strings):
            context.error("Padding detected between function and opening parenthesis")
