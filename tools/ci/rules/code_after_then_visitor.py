from .lua_style_visitor import LuaStyleVisitor
import re

class CodeAfterThenVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        line_ncns = context.line_no_comments_or_strings
        match = re.search(r"\bthen\b\s*[^\s]", line_ncns)
        if match:
            context.error("Code after a condition ends should be on its own line.")
