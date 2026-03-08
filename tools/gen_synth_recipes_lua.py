#!/usr/bin/env python3
"""
リモートDBの synth_recipes から Lua 用の逆引きレシピテーブルを生成する。

生成物:
- scripts/globals/synth_recipes_data.lua
- scripts/globals/synth_result_names_cp932.lua
"""

from __future__ import annotations

import re
import shlex
import subprocess
import sys
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path


ROOT_DIR = Path(__file__).resolve().parents[1]
OUTPUT_PATH = ROOT_DIR / "scripts" / "globals" / "synth_recipes_data.lua"
CP932_NAME_OUTPUT_PATH = ROOT_DIR / "scripts" / "globals" / "synth_result_names_cp932.lua"
ITEM_NAME_JA_PATH = ROOT_DIR / "scripts" / "globals" / "item_name_ja.lua"
SSH_HOST = "ffxi-254"

SYNTH_QUERY = (
    "SELECT ID, Crystal, "
    "Ingredient1, Ingredient2, Ingredient3, Ingredient4, "
    "Ingredient5, Ingredient6, Ingredient7, Ingredient8, "
    "Result, "
    "Wood, Smith, Gold, Cloth, Leather, Bone, Alchemy, Cook "
    "FROM synth_recipes "
    "WHERE Desynth = 0 "
    "ORDER BY Result, ID;"
)

GUILD_SHOP_QUERY = (
    "SELECT itemid, CASE "
    "WHEN min_price > 0 AND max_price > 0 THEN LEAST(min_price, max_price) "
    "WHEN min_price > 0 THEN min_price "
    "WHEN max_price > 0 THEN max_price "
    "ELSE 0 END AS shop_price "
    "FROM guild_shops "
    "WHERE min_price > 0 OR max_price > 0;"
)

SKILL_COLUMNS = [
    "Wood",
    "Smith",
    "Gold",
    "Cloth",
    "Leather",
    "Bone",
    "Alchemy",
    "Cook",
]

SHOP_MARKERS = (
    "sendGuild(",
    "xi.shop.generalGuild(",
    "xi.shop.general(",
    "xi.shop.nation(",
    "xi.shop.handleRegionalShop(",
    "xi.shop.handleValerianoShop(",
    "xi.shop.celebratory(",
    "xi.shop.curioVendorMoogle(",
)


@dataclass
class RecipeRow:
    recipe_id: int
    crystal: int
    ingredients: list[int]
    result: int
    skill: str
    skill_level: int
    required_items: list[tuple[int, int, bool]]
    npc_buyable_only: bool


def run_remote_query(query: str) -> str:
    """SSH 経由で MariaDB へ接続し、タブ区切りの結果を返す。"""
    remote_command = " ".join(
        [
            "mysql",
            "-N",
            "-B",
            "-u",
            "xiuser",
            "-p716o1891",
            "xidb",
            "-e",
            shlex.quote(query),
        ]
    )

    result = subprocess.run(
        ["ssh", SSH_HOST, remote_command],
        check=False,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )

    if result.returncode != 0:
        stderr = result.stderr.strip() or "(no stderr)"
        raise RuntimeError(f"リモートクエリに失敗しました: {stderr}")

    return result.stdout


def set_min_price(price_map: dict[int, int], itemid: int, price: int) -> None:
    """同一 itemid に複数価格がある場合は最安値を保持する。"""
    if itemid <= 0 or price <= 0:
        return

    previous = price_map.get(itemid)
    if previous is None or price < previous:
        price_map[itemid] = price


def load_enum_item_map() -> dict[str, int]:
    """scripts/enum/item.lua から列挙名 -> itemid を読み込む。"""
    item_lua = ROOT_DIR / "scripts" / "enum" / "item.lua"
    if not item_lua.exists():
        return {}

    text_data = item_lua.read_text(encoding="utf-8", errors="ignore")
    out: dict[str, int] = {}
    for match in re.finditer(r"^\s*([A-Z0-9_]+)\s*=\s*(\d+)\s*,", text_data, flags=re.MULTILINE):
        out[match.group(1)] = int(match.group(2))
    return out


def extract_item_price_map_from_lua_text(text_data: str, enum_map: dict[str, int]) -> dict[int, int]:
    """Lua の { item, price } 形式から itemid -> price を抽出する。"""
    out: dict[int, int] = {}
    for match in re.finditer(r"\{\s*(?:xi\.item\.([A-Z0-9_]+)|(\d+))\s*,\s*(\d+)", text_data):
        enum_key = match.group(1)
        itemid_num = match.group(2)
        price = int(match.group(3))

        if enum_key:
            itemid = enum_map.get(enum_key)
            if itemid is None:
                continue
        else:
            itemid = int(itemid_num)

        set_min_price(out, itemid, price)

    return out


def load_npc_shop_price_map() -> dict[int, int]:
    """
    MarketHelper と同じ考え方で NPC 販売価格マップを構築する。
    - guild_shops
    - scripts/globals/shop.lua
    - scripts/zones/*/npcs/*.lua
    """
    price_map: dict[int, int] = {}

    guild_output = run_remote_query(GUILD_SHOP_QUERY)
    for line in guild_output.splitlines():
        if not line.strip():
            continue
        itemid_text, price_text = line.split("\t", 1)
        set_min_price(price_map, int(itemid_text), int(price_text))

    enum_map = load_enum_item_map()

    shop_lua_path = ROOT_DIR / "scripts" / "globals" / "shop.lua"
    if shop_lua_path.exists():
        shop_lua_text = shop_lua_path.read_text(encoding="utf-8", errors="ignore")
        for itemid, price in extract_item_price_map_from_lua_text(shop_lua_text, enum_map).items():
            set_min_price(price_map, itemid, price)

    npc_root = ROOT_DIR / "scripts" / "zones"
    if npc_root.exists():
        for npc_script in npc_root.glob("*/npcs/*.lua"):
            text_data = npc_script.read_text(encoding="utf-8", errors="ignore")
            if not any(marker in text_data for marker in SHOP_MARKERS):
                continue
            for itemid, price in extract_item_price_map_from_lua_text(text_data, enum_map).items():
                set_min_price(price_map, itemid, price)

    return price_map


def determine_skill(values: list[int]) -> tuple[str, int]:
    """最大スキルの列名と値を返す。同点時は列定義順を優先する。"""
    max_value = max(values)
    if max_value <= 0:
        return "Unknown", 0

    for name, value in zip(SKILL_COLUMNS, values):
        if value == max_value:
            return name, value

    return "Unknown", 0


def build_required_items(
    crystal: int,
    ingredients: list[int],
    npc_price_map: dict[int, int],
) -> tuple[list[tuple[int, int, bool]], bool]:
    """素材のみを集計し、NPC 販売可否付き一覧を返す。"""
    counts: dict[int, int] = defaultdict(int)
    order: list[int] = []

    for itemid in ingredients:
        if itemid <= 0:
            continue
        if counts[itemid] == 0:
            order.append(itemid)
        counts[itemid] += 1

    required_items: list[tuple[int, int, bool]] = []
    npc_buyable_only = True
    for itemid in order:
        npc_buyable = itemid in npc_price_map
        required_items.append((itemid, counts[itemid], npc_buyable))
        if not npc_buyable:
            npc_buyable_only = False

    if not required_items:
        npc_buyable_only = False

    return required_items, npc_buyable_only


def parse_rows(raw_output: str, npc_price_map: dict[int, int]) -> dict[int, list[RecipeRow]]:
    """synth_recipes の行を成果物IDごとのレシピ配列へ変換する。"""
    recipes_by_result: dict[int, list[RecipeRow]] = defaultdict(list)

    for line_number, line in enumerate(raw_output.splitlines(), start=1):
        if not line.strip():
            continue

        columns = line.split("\t")
        if len(columns) != 19:
            raise ValueError(
                f"{line_number}行目の列数が不正です。期待値=19 実際={len(columns)} 行={line!r}"
            )

        numbers = [int(value) for value in columns]
        recipe_id = numbers[0]
        crystal = numbers[1]
        ingredients = [value for value in numbers[2:10] if value > 0]
        result = numbers[10]
        skill_name, skill_level = determine_skill(numbers[11:19])
        required_items, npc_buyable_only = build_required_items(crystal, ingredients, npc_price_map)

        recipes_by_result[result].append(
            RecipeRow(
                recipe_id=recipe_id,
                crystal=crystal,
                ingredients=ingredients,
                result=result,
                skill=skill_name,
                skill_level=skill_level,
                required_items=required_items,
                npc_buyable_only=npc_buyable_only,
            )
        )

    return dict(recipes_by_result)


def render_lua(recipes_by_result: dict[int, list[RecipeRow]]) -> str:
    """メインのレシピ逆引き Lua を生成する。"""
    lines = [
        "-- Auto-generated by tools/gen_synth_recipes_lua.py. DO NOT EDIT.",
        "xi = xi or {}",
        "xi.synth_recipes = {",
    ]

    for result_id in sorted(recipes_by_result):
        lines.append(f"    [{result_id}] = {{")
        for recipe in recipes_by_result[result_id]:
            ingredient_text = ", ".join(str(item_id) for item_id in recipe.ingredients)
            required_item_text = ", ".join(
                "{ "
                + f"item_id = {item_id}, "
                + f"quantity = {quantity}, "
                + f"npc_buyable = {'true' if npc_buyable else 'false'} "
                + "}"
                for item_id, quantity, npc_buyable in recipe.required_items
            )
            lines.append(
                "        "
                + "{ "
                + f"crystal = {recipe.crystal}, "
                + f"ingredients = {{ {ingredient_text} }}, "
                + f'skill = "{recipe.skill}", '
                + f"skill_level = {recipe.skill_level}, "
                + f"npc_buyable_only = {'true' if recipe.npc_buyable_only else 'false'}, "
                + f"required_items = {{ {required_item_text} }}, "
                + f"recipe_id = {recipe.recipe_id} "
                + "},"
            )
        lines.append("    },")

    lines.append("}")
    lines.append("")
    return "\n".join(lines)


def parse_item_name_ja() -> dict[str, int | list[int]]:
    """item_name_ja.lua から日本語名辞書を抽出する。"""
    mapping: dict[str, int | list[int]] = {}
    text_data = ITEM_NAME_JA_PATH.read_text(encoding="utf-8")

    for line in text_data.splitlines():
        stripped = line.strip()
        if not stripped.startswith('["'):
            continue

        try:
            key_part, value_part = stripped.split("] = ", 1)
        except ValueError:
            continue

        name = key_part[2:-1]
        value_text = value_part.rstrip(",")
        if value_text.startswith("{") and value_text.endswith("}"):
            values = [int(part.strip()) for part in value_text[1:-1].split(",") if part.strip()]
            mapping[name] = values
        else:
            mapping[name] = int(value_text)

    return mapping


def filter_synth_result_names(
    item_name_map: dict[str, int | list[int]],
    recipes_by_result: dict[int, list[RecipeRow]],
) -> dict[str, int | list[int]]:
    """合成結果として存在する itemId だけを残した日本語名辞書を作る。"""
    result_ids = set(recipes_by_result)
    filtered: dict[str, int | list[int]] = {}

    for name, value in item_name_map.items():
        if isinstance(value, int):
            if value in result_ids:
                filtered[name] = value
            continue

        candidates = [item_id for item_id in value if item_id in result_ids]
        if not candidates:
            continue
        if len(candidates) == 1:
            filtered[name] = candidates[0]
        else:
            filtered[name] = candidates

    return filtered


def collect_recipe_related_item_ids(recipes_by_result: dict[int, list[RecipeRow]]) -> set[int]:
    """合成結果名表示に必要な itemId 一式を収集する。"""
    item_ids: set[int] = set(recipes_by_result)
    for recipes in recipes_by_result.values():
        for recipe in recipes:
            if recipe.crystal > 0:
                item_ids.add(recipe.crystal)
            for item_id in recipe.ingredients:
                if item_id > 0:
                    item_ids.add(item_id)
    return item_ids


def build_cp932_display_name_map(
    item_name_map: dict[str, int | list[int]],
    allowed_item_ids: set[int],
) -> dict[int, str]:
    """表示用の itemId -> 日本語名 を作る。"""
    display_name_map: dict[int, str] = {}
    for name, value in item_name_map.items():
        if isinstance(value, int):
            if value in allowed_item_ids and value not in display_name_map:
                display_name_map[value] = name
            continue

        for item_id in value:
            if item_id in allowed_item_ids and item_id not in display_name_map:
                display_name_map[item_id] = name

    return display_name_map


def render_cp932_name_lua(
    name_map: dict[str, int | list[int]],
    display_name_map: dict[int, str],
) -> str:
    """合成結果入力用辞書と表示用 CP932 名辞書を生成する。"""
    lines = [
        "-- Auto-generated by tools/gen_synth_recipes_lua.py. DO NOT EDIT.",
        "xi = xi or {}",
        "xi.synth_result_names_cp932 = {}",
        "xi.synth_result_id_to_name_cp932 = {}",
        "",
    ]

    for name in sorted(name_map):
        key_bytes = ",".join(f"0x{byte:02X}" for byte in name.encode("cp932"))
        value = name_map[name]
        if isinstance(value, int):
            value_lua = str(value)
        else:
            value_lua = "{ " + ", ".join(str(item_id) for item_id in value) + " }"
        lines.append(f"xi.synth_result_names_cp932[string.char({key_bytes})] = {value_lua}")

    for item_id in sorted(display_name_map):
        key_bytes = ",".join(f"0x{byte:02X}" for byte in display_name_map[item_id].encode("cp932"))
        lines.append(f"xi.synth_result_id_to_name_cp932[{item_id}] = string.char({key_bytes})")

    lines.append("")
    return "\n".join(lines)


def main() -> int:
    try:
        npc_price_map = load_npc_shop_price_map()
        raw_output = run_remote_query(SYNTH_QUERY)
        recipes_by_result = parse_rows(raw_output, npc_price_map)
        synth_lua_text = render_lua(recipes_by_result)
        item_name_map = parse_item_name_ja()
        cp932_name_map = filter_synth_result_names(item_name_map, recipes_by_result)
        cp932_display_name_map = build_cp932_display_name_map(
            item_name_map,
            collect_recipe_related_item_ids(recipes_by_result),
        )
        cp932_lua_text = render_cp932_name_lua(cp932_name_map, cp932_display_name_map)
        OUTPUT_PATH.write_text(synth_lua_text, encoding="utf-8", newline="\n")
        CP932_NAME_OUTPUT_PATH.write_text(cp932_lua_text, encoding="utf-8", newline="\n")
    except Exception as exc:  # noqa: BLE001
        print(f"[gen_synth_recipes_lua] {exc}", file=sys.stderr)
        return 1

    recipe_count = sum(len(recipes) for recipes in recipes_by_result.values())
    print(
        f"[gen_synth_recipes_lua] generated {OUTPUT_PATH} "
        f"(results={len(recipes_by_result)}, recipes={recipe_count}, "
        f"cp932_names={len(cp932_name_map)}, npc_prices={len(npc_price_map)})"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
