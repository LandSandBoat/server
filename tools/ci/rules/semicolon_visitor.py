from .lua_style_visitor import LuaStyleVisitor
import re

class SemicolonVisitor(LuaStyleVisitor):
    """
    Visitor for semicolon checks.
    Ensures no semicolons are used in Lua scripts, ignoring those inside strings.
    """
    def visit(self, line, context):
        for _ in re.finditer(r";", context.line_no_comments_or_strings):
            context.error("Semicolon detected in line.")
