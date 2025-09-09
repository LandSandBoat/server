from .lua_style_visitor import LuaStyleVisitor
import re

class VariableNamingVisitor(LuaStyleVisitor):
    """
    Visitor for variable naming checks.
    Ensures variables do not use underscores and are lowerCamelCased, except for 'ID'.
    """
    def visit(self, line, context):
        for match in re.finditer(r"local (?=[^(ID)])(?=[A-Z]){1,}", context.line_no_comments_or_strings):
            context.error("Capitalised local name")
        if "local " in context.line_no_comments_or_strings and " =" in context.line_no_comments_or_strings:
            var_line = context.line_no_comments_or_strings.split(" =", 1)[0]
            var_line = var_line.replace('local','').strip()
            if var_line != '':
                for part in var_line.split(','):
                    part = part.strip()
                    if len(part) > 1 and '_' in part:
                        context.error("Underscore in variable name")
