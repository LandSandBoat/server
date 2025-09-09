from .lua_style_visitor import LuaStyleVisitor

class NewlineAfterEndVisitor(LuaStyleVisitor):
    """
    Visitor for newline after 'end' checks.
    Ensures an empty newline is required after 'end' if the code on the following line is at the same indentation level.
    """
    def visit(self, line, context):
        # Only check lines that are 'end' (ignoring whitespace and comments)
        if context.line_no_comments.strip() == 'end':
            num_lines = len(context.lines)
            if context.counter < num_lines and context.lines[context.counter].strip() != "":
                current_indent = len(line) - len(line.lstrip(' '))
                next_indent = len(context.lines[context.counter]) - len(context.lines[context.counter].lstrip(' '))
                if current_indent == next_indent:
                    context.error("Newline required after end with code following on same level")
