import re
import os

logging = False
sql_items = dict()
npc_items = dict()
errors = list()

server_dir_path = os.path.normpath(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
)


def from_server_path(path):
    return os.path.normpath(os.path.join(server_dir_path, path))


def load_item_enums(enum_path):
    enums = {}
    current_enum_type = None
    recording = False

    with open(enum_path, "r", errors="ignore") as f:
        for line in f:
            stripped = line.strip()

            # Start recording when we see the enum marker
            if not recording:
                m = re.match(r"^---@enum\s+(xi\.\w+)", stripped)
                if m:
                    current_enum_type = m.group(1)
                    recording = True
                continue

            if recording:
                if stripped == "}":
                    recording = False
                    current_enum_type = None
                    continue

                # Skip comments and empty lines
                if not stripped or stripped.startswith("--"):
                    continue

                m = re.match(r"^(\w+)\s*=\s*(\d+),?", stripped)
                if m and current_enum_type:
                    name, val = m.groups()
                    enums[f"{current_enum_type}.{name}"] = int(val)

    return enums


item_enums = load_item_enums("scripts/enum/item.lua")


def process_matches(match, line):
    split = []

    if bool(re.match(match, line, re.I)):
        # advance past the initial string to the parenthesis
        sliced = line[len(sql_line) :]

        # strip the parenthesis, semi-colon, newline chars and comments
        sliced = sliced.split("--")[0]
        sliced = sliced[2:-3]

        split = sliced.split(",")

    return split


def log(message, *args):
    if logging:
        length = len(args)
        if length == 2:
            print(message.format(args[0], args[1]))
        elif length == 3:
            print(message.format(args[0], args[1], args[2]))


def process_npc(path):
    with open(path, mode="r", errors="ignore") as npc_file:
        in_stock = False
        brace_depth = 0

        for line in npc_file:
            stripped = line.strip()

            if not in_stock and "local stock" in stripped:
                in_stock = True
                continue

            if in_stock:
                brace_depth += stripped.count("{")
                brace_depth -= stripped.count("}")

                if brace_depth < 1:
                    continue

                # Match inner stock lines like: { item_id, buy_price, [ignored], ... }
                match = re.match(r"\{\s*(.+?)\s*\}", stripped)
                if not match:
                    continue

                # Extract and split the inner values
                values = [v.strip() for v in match.group(1).split(",") if v.strip()]
                if len(values) < 2:
                    continue  # malformed or incomplete line

                item_id_raw, buy_price = values[0], values[1]

                # Resolve enum or raw
                if item_id_raw.startswith("xi.item."):
                    resolved = item_enums.get(item_id_raw)
                    if resolved is None:
                        errors.append(
                            f"Unknown item enum {item_id_raw} found in script {path}."
                        )
                        continue  # enum not found
                    item_id = str(resolved)
                elif item_id_raw.isdigit():
                    item_id = item_id_raw
                else:
                    errors.append(f"Unknown item type found in script {path}.")
                    continue  # unhandled type

                log(f"Found item {item_id} with buy price {buy_price}")

                if item_id in sql_items and int(sql_items[item_id]) > int(buy_price):
                    errors.append(
                        f"Found item {item_id_raw} with buy price {buy_price} which is lower than sell price {sql_items[item_id]} in script {path}."
                    )


# process item_basic for item ids and base sell prices
sql_line = "INSERT INTO `item_basic` VALUES"
with open(from_server_path("sql/item_basic.sql"), mode="r", errors="ignore") as items:
    for line in items:
        split = process_matches(sql_line, line)

        # if the item can be sold to the shop and the sell price isn't 0
        if len(split) != 0 and split[-2] == "0" and split[-1] != "0":
            sql_items[split[0]] = split[-1]

            log(f"Added item {split[0]} with base sell price {split[-1]}")

# iterate over npcs in ../scripts/zones/.../npcs/*.lua
with os.scandir(from_server_path("scripts/zones")) as iterator:
    for entry in iterator:
        if entry.is_dir():
            npc_path = os.path.join(entry.path, "npcs")
            # iterate over npcs folder if it exists
            if os.path.exists(npc_path):
                with os.scandir(npc_path) as npc_iterator:
                    for npc in npc_iterator:
                        if npc.is_file():
                            process_npc(npc.path)

# process guild_shops.sql for item ids and min_price
sql_line = "INSERT INTO `guild_shops` VALUES"
with open(from_server_path("sql/guild_shops.sql"), mode="r", errors="ignore") as guilds:
    for line in guilds:
        split = process_matches(sql_line, line)
        if len(split) != 0:
            item_id = split[1].strip()
            min_price = split[2].strip()
            max_price = split[3].strip()

            log(
                f"Found guild item {item_id} with min price {min_price} and max price {max_price}"
            )
            if item_id in sql_items and int(sql_items[item_id]) > int(min_price):
                errors.append(
                    f"Found guild item {item_id} with min price {min_price} which is lower than sell price {sql_items[item_id]} for guild shop {split[0].strip()}."
                )

for error in errors:
    print(error)
if len(errors) > 0:
    print(f"Found {len(errors)} errors.")
