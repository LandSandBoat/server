from .lua_style_visitor import LuaStyleVisitor
import re

class CommentBlockLengthVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        comment_header = line.rstrip("\n")
        if re.search(r"^-+$", comment_header) and len(comment_header) > 2 and len(comment_header) != 35:
            context.error("Standard comment block lines of '-' should be 35 characters.")
