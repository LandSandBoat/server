from .lua_style_visitor import LuaStyleVisitor
import re

deprecated_functions = [
    ["table.getn", "#t"],
    ["os.time", "GetSystemTime"],
]

deprecated_requires = [
    "scripts/globals/items",
    "scripts/globals/keyitems",
    "scripts/globals/loot",
    "scripts/globals/msg",
    "scripts/globals/settings",
    "scripts/globals/spell_data",
    "scripts/globals/status",
    "scripts/globals/titles",
    "scripts/globals/zone",
    "scripts/enum",
    "IDs",
]

invalid_enums = [
    "xi.items.",
    "xi.effects.",
]

disallowed_numeric_parameters = {
    "addItem"                 : [ 0 ],
    "addKeyItem"              : [ 0 ],
    "addSpell"                : [ 0 ],
    "addStatusEffect"         : [ 0 ],
    "addStatusEffectSilent"   : [ 0 ],
    "addUsedItem"             : [ 0 ],
    "canLearnSpell"           : [ 0 ],
    "delItem"                 : [ 0 ],
    "delContainerItems"       : [ 0 ],
    "delKeyItem"              : [ 0 ],
    "delSpell"                : [ 0 ],
    "delStatusEffect"         : [ 0 ],
    "delStatusEffectEx"       : [ 0 ],
    "delUniqueEvent"          : [ 0 ],
    "getEquipID"              : [ 0 ],
    "getEquippedItem"         : [ 0 ],
    "getItemQty"              : [ 0 ],
    "hasCompletedUniqueEvent" : [ 0 ],
    "hasItem"                 : [ 0 ],
    "hasItemQty"              : [ 0 ],
    "hasSpell"                : [ 0 ],
    "messageBasic"            : [ 0 ],
    "messageName"             : [ 0 ],
    "messageSpecial"          : [ 0 ],
    "messageText"             : [ 0 ],
    "npcUtil.giveKeyItem"     : [ 1, 2 ],
    "npcUtil.giveItem"        : [ 1 ],
    "npcUtil.tradeHas"        : [ 1 ],
    "npcUtil.tradeHasExactly" : [ 1 ],
    "setUniqueEvent"          : [ 0 ],
    "showText"                : [ 0 ],
}

class DeprecatedFunctionVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        for entry in deprecated_functions:
            deprecated_func = entry[0]
            replacement = entry[1]
            if deprecated_func in line:
                context.error(f"Use of deprecated function: {deprecated_func}. Suggested replacement: {replacement}")

class DeprecatedRequireVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        if "require(" in context.line_no_comments_or_strings:
            for deprecated_str in deprecated_requires:
                if deprecated_str in context.line_no_comments_or_strings:
                    if deprecated_str == "IDs":
                        context.error("IDs requires should be replaced with references to zones[xi.zone.ZONE_ENUM]")
                    else:
                        context.error(f"Use of deprecated/unnecessary require: {deprecated_str}. This should be removed")

class InvalidEnumVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        for invalid_enum in invalid_enums:
            if invalid_enum in line:
                context.error(f"Potential invalid enum reference used: {invalid_enum}.  Did you mean the one without an s?")

class FunctionParameterMagicNumberVisitor(LuaStyleVisitor):
    def visit(self, line, context):
        for fn_name, param_locations in disallowed_numeric_parameters.items():
            regex_str = r'{0}\(([^)]+)\)'.format(fn_name)
            for parameter_str in re.findall(regex_str, context.line_no_comments_or_strings):
                parameter_list = parameter_str.split(",")
                for position in param_locations:
                    if position < len(parameter_list) and parameter_list[position].strip().isnumeric():
                        context.error(f"Magic Number is not allowed at this location ({position}).")
