from .lua_style_visitor import LuaStyleVisitor
import re

class ConditionalPaddingVisitor(LuaStyleVisitor):
    """
    Visitor for conditional padding checks.
    Ensures logical operators (and/or) do not have excessive spaces around them.
    """
    def visit(self, line, context):
        if re.search(r"\s{2,}(and|or)(\s{1,}|$)|\s{1,}(and|or)\s{2,}", context.line_no_comments_or_strings):
            context.error("Multiple spaces detected around logical operator.")
