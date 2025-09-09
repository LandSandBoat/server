from .lua_style_visitor import LuaStyleVisitor
import re

class TableFormattingVisitor(LuaStyleVisitor):
    """
    Visitor for table formatting checks.
    Checks for Allman brace style and proper spacing in table definitions.
    Uses comment-stripped line for regex checks to avoid interference from comments.
    """
    def visit(self, line, context):
        if re.search(r"[ ]{0,}=[ ]{0,}\{[ ]{0,}$", context.line_no_comments_or_strings):
            context.error("Incorrectly defined table")
        for _ in re.finditer(r"\{[^ \n\}]", context.line_no_comments_or_strings):
            context.error("Table opened without an appropriate following space or newline")
        for _ in re.finditer(r"[^ \n\{]\}", context.line_no_comments_or_strings):
            context.error("Table closed without an appropriate preceding space or newline")
