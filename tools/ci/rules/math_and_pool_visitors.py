from .lua_style_visitor import LuaStyleVisitor
import re

class MathRandomBoundsVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        randString = re.search(r'math\.random\(([^()]*)\)', line)
        if randString:
            paramList = randString.group(0).split(',')
            if len(paramList) != 2:
                context.error(f"math.random() calls should have upper and lower bounds ({randString.group(0)}).")

class GetPoolMagicNumberVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        match = re.search(r":getPool\(\)\s*(==|~=|<=|>=|<|>)\s*\d+", line)
        if match:
            context.error(":getPool() compared to integer literal (magic number) using a conditional operator is not allowed.")
