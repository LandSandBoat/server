from .lua_style_visitor import LuaStyleVisitor
import re

class NoNewlineBeforeEndVisitor(LuaStyleVisitor):
    """
    Visitor for no newline before 'end' checks.
    Ensures 'end' does not have a newline preceding it.
    """
    def visit(self, line, context):
        if re.search(r'\bend\b', context.line_no_comments_or_strings) and context.counter > 1 and context.lines[context.counter - 2].strip() == '':
            context.error("No newlines before end statement")
