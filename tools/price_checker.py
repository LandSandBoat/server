import re
import os

logging = False
sql_items = dict()
npc_items = dict()
errors = list()

local_path = os.path.dirname(os.path.realpath(__file__))


def process_matches(match, line):
    split = []

    if bool(re.match(match, line, re.I)):
        # advance past the initial string to the parenthesis
        sliced = line[len(sql_line) :]

        # strip the parenthesis, semi-colon, newline chars and comments
        sliced = sliced.split('--')[0]
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
        found_stock = False
        found_brace = False
        for line in npc_file:
            # find local stock
            if "local stock" in line:
                found_stock = True
            # find the starting brace
            elif found_stock and "{" in line:
                found_brace = True
            # next lines after local stock and brace are item and buy prices
            elif found_stock and found_brace:
                if "}" in line:
                    break
                else:
                    split = line.split(",")
                    if len(split) > 1:
                        item_id = split[0].strip()
                        buy_price = "".join(
                            filter(lambda x: x.isdigit(), split[1].strip())
                        )
                        log(("Found item {0} with buy price {1}"), item_id, buy_price)
                        if item_id in sql_items and int(sql_items[item_id]) > int(
                            buy_price
                        ):
                            errors.append(
                                (
                                    "Found item {0}"
                                    " with buy price {1}"
                                    " which is lower than"
                                    " sell price {2}"
                                    " in script {3}"
                                ).format(item_id, buy_price, sql_items[item_id], path)
                            )


# process item_basic for item ids and base sell prices
sql_line = "INSERT INTO `item_basic` VALUES"
with open(
    os.path.join(local_path, "../sql/item_basic.sql"), mode="r", errors="ignore"
) as items:
    for line in items:
        split = process_matches(sql_line, line)

        # if the item can be sold to the shop and the sell price isn't 0
        if len(split) != 0 and split[-2] == "0" and split[-1] != "0":
            sql_items[split[0]] = split[-1]

            log(("Added item {0} with base sell price {1}"), split[0], split[-1])

# iterate over npcs in ../scripts/zones/.../npcs/*.lua
with os.scandir(os.path.join(local_path, "../scripts/zones")) as iterator:
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
with open(
    os.path.join(local_path, "../sql/guild_shops.sql"), mode="r", errors="ignore"
) as guilds:
    for line in guilds:
        split = process_matches(sql_line, line)
        if len(split) != 0:
            item_id = split[1].strip()
            min_price = split[2].strip()
            max_price = split[3].strip()

            log(
                ("Found guild item {0} with min price {1} and max price {2}"),
                item_id,
                min_price,
                max_price,
            )
            if item_id in sql_items and int(sql_items[item_id]) > int(min_price):
                errors.append(
                    (
                        "Found guild item {0}"
                        " with min price {1}"
                        " which is lower than sell price {2}"
                        " for guild shop {3}"
                    ).format(item_id, min_price, sql_items[item_id], split[0].strip())
                )

for error in errors:
    print(error)
    print("Found {0} errors".format(len(errors)))
