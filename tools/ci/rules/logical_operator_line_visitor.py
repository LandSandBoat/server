from .lua_style_visitor import LuaStyleVisitor

class LogicalOperatorLineVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        line_nc = context.line_no_comments
        stripped_line = line_nc.strip()
        if stripped_line.startswith('and ') or stripped_line.startswith('or '):
            context.error('Multiline conditions should not start with and|or')
        if stripped_line.endswith('not'):
            context.error('Multiline conditions should not end with not')
