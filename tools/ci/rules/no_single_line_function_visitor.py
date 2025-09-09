from .lua_style_visitor import LuaStyleVisitor
import re

class NoSingleLineFunctionVisitor(LuaStyleVisitor):
    """
    Visitor for no single line function checks.
    Ensures functions do not begin and end on a single line.
    """
    def visit(self, line, context):
        if re.search(r'\bfunction\b', context.line_no_comments_or_strings) and re.search(r'\bend\b', context.line_no_comments_or_strings):
            context.error("Function begins and ends on same line")
