from .lua_style_visitor import LuaStyleVisitor
import regex
import re

class ConditionalFormattingVisitor(LuaStyleVisitor):
    """
    Visitor for conditional formatting checks.
    Checks formatting of a full multi-line condition string.
    """
    def visit(self, condition, context):
        condition_str = condition.replace('elseif','').replace('if','').replace('then','').strip()
        paren_regex = regex.compile(r"\((([^\)\(]+)|(?R))*+\)", re.S)
        removed_paren_str = regex.sub(paren_regex, "", condition_str)
        if removed_paren_str == "":
            context.error("Outer parentheses should be removed in condition")
        if re.search(r"== true|== false|~= true|~= false", condition):
            context.error("Boolean with explicit value check")
        # For multiline conditions, check each line for length and logical operators
        lines = condition.split('\n')
        for line in lines:
            compare_line = context.line_no_comments_or_strings.rstrip().lstrip()
            if (" and " in compare_line or " or " in compare_line) and len(compare_line) > 80:
                context.error("Multiline conditional line too long (>80 chars with logical operator)")
