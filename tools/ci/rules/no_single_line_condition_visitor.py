from .lua_style_visitor import LuaStyleVisitor
import re

class NoSingleLineConditionVisitor(LuaStyleVisitor):
    """
    Visitor for no single line condition checks.
    Ensures conditions do not begin and end on a single line.
    """
    def visit(self, line, context):
        if re.search(r'\bif\b', context.line_no_comments_or_strings) and re.search(r'\bend\b', context.line_no_comments_or_strings):
            context.error("Condition begins and ends on a single line")
