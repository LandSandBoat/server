import argparse

# 2 arguments:
# 1. The file path of the input file
# 2. The file path of the output file
#
# Example:
# python generate_spec_file.py ./src/map/lua/lua_action.cpp ./scripts/specs/generated/action.lua

arg_parser = argparse.ArgumentParser(
    description="Generate spec file for a given source file"
)

arg_parser.add_argument("input_file", type=str, help="The file path of the input file")
arg_parser.add_argument(
    "output_file", type=str, help="The file path of the output file"
)

args = arg_parser.parse_args()

input_file = args.input_file
output_file = args.output_file

# void CLuaAction::setAnimation(uint32 actionTargetID, uint16 animation)

# auto CLuaAction::getCategory() -> uint8

# void CLuaAction::Register()
# {
#     SOL_USERTYPE("CAction", CLuaAction);
#     SOL_REGISTER("ID", CLuaAction::ID);
#     SOL_REGISTER("getPrimaryTargetID", CLuaAction::getPrimaryTargetID);
#     SOL_REGISTER("getRecast", CLuaAction::getRecast);
#     SOL_REGISTER("setRecast", CLuaAction::setRecast);
#     SOL_REGISTER("actionID", CLuaAction::actionID);
#     SOL_REGISTER("getParam", CLuaAction::getParam);
#     SOL_REGISTER("param", CLuaAction::param);
#     SOL_REGISTER("messageID", CLuaAction::messageID);
#     SOL_REGISTER("getMsg", CLuaAction::getMsg);
#     SOL_REGISTER("getAnimation", CLuaAction::getAnimation);
#     SOL_REGISTER("setAnimation", CLuaAction::setAnimation);
#     SOL_REGISTER("getCategory", CLuaAction::getCategory);
#     SOL_REGISTER("setCategory", CLuaAction::setCategory);
#     SOL_REGISTER("speceffect", CLuaAction::speceffect);
#     SOL_REGISTER("reaction", CLuaAction::reaction);
#     SOL_REGISTER("modifier", CLuaAction::modifier);
#     SOL_REGISTER("additionalEffect", CLuaAction::additionalEffect);
#     SOL_REGISTER("addEffectParam", CLuaAction::addEffectParam);
#     SOL_REGISTER("addEffectMessage", CLuaAction::addEffectMessage);
#     SOL_REGISTER("addAdditionalTarget", CLuaAction::addAdditionalTarget);
# };


def cpp_type_to_lua_type(type_str):
    match type_str:
        case "uint8":
            return "number"
        case "uint16":
            return "number"
        case "uint32":
            return "number"
        case "uint64":
            return "number"
        case "int8":
            return "number"
        case "int16":
            return "number"
        case "int32":
            return "number"
        case "int64":
            return "number"
        case "float":
            return "number"
        case "double":
            return "number"
        case "std::string":
            return "string"
        case "std::vector<uint8>":
            return "table"
        case "std::vector<uint16>":
            return "table"
        case "std::vector<uint32>":
            return "table"
        case "std::vector<uint64>":
            return "table"
        case "std::vector<int8>":
            return "table"
        case "std::vector<int16>":
            return "table"
        case "std::vector<int32>":
            return "table"
        case "std::vector<int64>":
            return "table"
        case "std::vector<float>":
            return "table"
        case "std::vector<double>":
            return "table"
        case "std::vector<std::string>":
            return "table"
        case "std::vector<std::vector<uint8>>":
            return "table"
        case "std::vector<std::vector<uint16>>":
            return "table"
        case "std::vector<std::vector<uint32>>":
            return "table"
        case "std::vector<std::vector<uint64>>":
            return "table"
        case "std::vector<std::vector<int8>>":
            return "table"
        case "std::vector<std::vector<int16>>":
            return "table"
        case "std::vector<std::vector<int32>>":
            return "table"
        case "std::vector<std::vector<int64>>":
            return "table"
        case "std::vector<std::vector<float>>":
            return "table"
        case "std::vector<std::vector<double>>":
            return "table"
        case "std::vector<std::vector<std::string>>":
            return "table"
        case "std::vector<std::vector<std::vector<uint8>>>":
            return


input_lines = []
with open(input_file, "r") as f:
    input_lines = f.readlines()

cpp_class_name = None
lua_class_name = None
for line in input_lines:
    # Extract class name (SOL_USERTYPE("CAction", CLuaAction); -> CAction)
    if "SOL_USERTYPE" in line:
        parts = line.split('"')
        cpp_class_name = parts[1].strip()

    # Extract out Lua class name (SOL_USERTYPE("CAction", CLuaAction); -> CLuaAction)
    if "SOL_USERTYPE" in line:
        parts = line.split(",")
        lua_class_name = parts[1].strip().split(")")[0].strip()

trailing_return_function_lines = []
traditional_function_lines = []
fields = []
for line in input_lines:
    # If line begins with auto, it's a function definition
    if line.startswith("auto"):
        trailing_return_function_lines.append(line.strip())

    # If a line doesn't start with whitespace, and contains :: and (, it's a function definition
    if not line.startswith(" ") and "::" in line and "(" in line:
        # If the part after the :: is the same as the class name, it's a constructor, don't add
        if lua_class_name in line.split("::")[1]:
            continue

        # If std::ostream is present, we don't need to add it
        if "std::ostream" in line:
            continue

        # We don't want the Register function
        if f"{lua_class_name}::Register()" in line:
            continue

        traditional_function_lines.append(line.strip())

print("Class name:", cpp_class_name)
print("Lua class name:", lua_class_name)

print("Trailing return function lines:")
for line in trailing_return_function_lines:
    if " -> " not in line:
        print("Error: auto function does not use '->' to specify return type!")
        print(f"    {line}")
        exit(1)

    print(f"    {line}")

    # auto CLuaAction::getCategory() -> uint8

    func_name = line.split(" ")[1].split("(")[0].split("::")[1]

    parameters_str = line.split("(")[1].split(")")[0]
    if parameters_str != "":
        parameter_pairs = parameters_str.split(",")
        print(parameter_pairs)
    else:
        print("        Parameters: None")

    return_type = line.split("->")[1].strip()
    print(
        f"        Return type: {return_type} (Lua type: {cpp_type_to_lua_type(return_type)})"
    )

    fields.append([func_name, cpp_type_to_lua_type(return_type)])

# Output spec file
print("Output file:", output_file)
print("---@meta\n")
print("---@class", lua_class_name)
for field in fields:
    print("---@field", field[0], field[1])
