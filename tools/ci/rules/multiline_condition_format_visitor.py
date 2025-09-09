from .lua_style_visitor import LuaStyleVisitor
import re

class MultilineConditionFormatVisitor(LuaStyleVisitor):
    """
    Visitor for multiline condition format checks.
    Ensures multi-line conditional blocks contain if/elseif and then on their own lines, with conditions indented between them.
    """
    def visit(self, line, context):
        # Skip comment-only lines
        stripped_line = re.sub(r'".*?"|\'.*?\'', "", context.line_no_comments_or_strings)
        if re.search(r'\bif\b', stripped_line) or re.search(r'\belseif\b', stripped_line):
            condition_start = stripped_line.replace('elseif','').replace('if','').strip()
            if not 'then' in condition_start and condition_start != '':
                context.error("Invalid multiline conditional format")
        if re.search(r'\bthen\b', stripped_line):
            condition_end = stripped_line.replace('then','').strip()
            if not 'if' in condition_end and condition_end != '':
                context.error("Invalid multiline conditional format")
