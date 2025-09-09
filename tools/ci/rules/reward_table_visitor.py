from .lua_style_visitor import LuaStyleVisitor
import re

disallowed_keys = [
    "ki", 
    "xp",
]

class RewardTableVisitor(LuaStyleVisitor):
    """
    Visitor for quest/mission.reward table checks.
    Tracks entry/exit of reward tables and checks for disallowed keys.
    """
    def __init__(self):
        self.in_reward_table = False
        self.brace_count = 0
        self.pending_reward_table = False
        self.reported_keys = set()

    def visit(self, line, context):
        # Detect assignment to quest.reward or mission.reward (brace may be on next line)
        if not self.in_reward_table:
            self.reported_keys.clear()
            if re.search(r'(quest|mission)\.reward\s*=\s*$', line.strip()):
                self.pending_reward_table = True
                return
            if re.search(r'(quest|mission)\.reward\s*=\s*\{', line):
                self.in_reward_table = True
                self.brace_count = line.count('{') - line.count('}')
                self._check_keys(line, context)
                return
        if self.pending_reward_table:
            if '{' in line:
                self.in_reward_table = True
                self.brace_count = line.count('{') - line.count('}')
                self.pending_reward_table = False
                self._check_keys(line, context)
                return
        if self.in_reward_table:
            self.brace_count += line.count('{') - line.count('}')
            self._check_keys(line, context)
            if self.brace_count <= 0:
                self.in_reward_table = False
                self.brace_count = 0
                self.reported_keys.clear()

    def _check_keys(self, line, context):
        for key in disallowed_keys:
            if re.search(rf'\b{key}\s*=', line) and key not in self.reported_keys:
                context.error(f"Found disallowed key '{key}' in reward table", suppress_line_ref=False)
                self.reported_keys.add(key)
