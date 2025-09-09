from .lua_style_visitor import LuaStyleVisitor

class IndentationVisitor(LuaStyleVisitor):
    """
    Visitor for indentation checks.
    Ensures indentation is in multiples of four spaces.
    """
    def visit(self, line, context):
        # Skip blank and comment-only lines
        if not line.strip() or line.strip().startswith('--'):
            return
        if (len(line) - len(line.lstrip(' '))) % 4 != 0:
            context.error("Indentation must be multiples of 4 spaces")
