from .lua_style_visitor import LuaStyleVisitor

class NoNewlineAfterFunctionDeclVisitor(LuaStyleVisitor):
    """
    Visitor for no newline after function declaration checks.
    Ensures function declarations do not have an empty newline following them.
    """
    def visit(self, line, context):
        # Use line with comments and strings removed
        line_ncns = context.line_no_comments_or_strings
        if 'function' in line_ncns and context.counter < len(context.lines) and context.lines[context.counter].strip() == '':
            context.error("No newlines after function declaration")
