from .lua_style_visitor import LuaStyleVisitor
import re

class ParameterPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for parameter padding checks.
    Ensures at least one space after every comma in function parameters and table data, ignoring commas inside string literals.
    """
    def visit(self, line, context):
        for _ in re.finditer(r",[^ \n]", context.line_no_comments_or_strings):
            context.error("Multiple parameters used without an appropriate following space or newline")
