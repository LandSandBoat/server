from pathlib import Path
from typing import Any

import yaml

from .common import (
    CASE_FNS,
    ENUMS_DIR,
    ENV,
    dotpath_get,
    pascal_to_snake,
    slug,
    snake_to_pascal,
)
from .yaml_loaders import FastLoader


def render_header(*, source_name: str, cls_name: str, underlying: str, is_flags: bool, case: str, values: dict[str, int]) -> str:
    if case not in CASE_FNS:
        raise ValueError(f"unknown enum case {case!r}; expected one of {sorted(CASE_FNS)}")
    cpp_names = {k: CASE_FNS[case](k) for k in values}
    return ENV.get_template("enum.h.j2").render(
        source_name=source_name,
        cls_name=cls_name,
        underlying=underlying,
        is_flags=is_flags,
        values=values,
        cpp_names=cpp_names,
        enum_width=max(len(n) for n in cpp_names.values()),
        quote_width=max(len(k) for k in values) + 2,
    )


def render_lua(*, source_name: str, lua_table: str, is_flags: bool, values: dict[str, int]) -> str:
    """Identifiers are the YAML key uppercased: `no_erase` -> `NO_ERASE`."""
    lua_names = {k: k.upper() for k in values}
    return ENV.get_template("enum.lua.j2").render(
        source_name=source_name,
        lua_table=lua_table,
        is_flags=is_flags,
        values=values,
        lua_names=lua_names,
        name_width=max(len(n) for n in lua_names.values()),
    )


def lua_block(lua_meta: dict[str, Any] | None, source_name: str, is_flags: bool, values: dict[str, int]) -> dict[str, str] | None:
    if not lua_meta or "table" not in lua_meta:
        return None
    table = lua_meta["table"]
    return {
        "name": pascal_to_snake(table.removeprefix("xi.")),
        "content": render_lua(source_name=source_name, lua_table=table, is_flags=is_flags, values=values),
    }


def emit_pure_enum(yaml_path: Path) -> dict[str, Any]:
    with yaml_path.open(encoding="utf-8") as f:
        doc = yaml.load(f, Loader=FastLoader)

    meta = doc.get("meta") or {}
    values = doc.get("values") or {}
    if not values:
        raise ValueError(f"{yaml_path.name}: no values: block")

    cpp = meta.get("cpp") or {}
    cls_name = cpp.get("class") or snake_to_pascal(yaml_path.stem)
    source_name = f"data/enums/{yaml_path.name}"
    is_flags = bool(meta.get("flags", False))
    return {
        "name": yaml_path.stem,
        "values": values,
        "source_name": source_name,
        "header": render_header(
            source_name=source_name,
            cls_name=cls_name,
            underlying=cpp.get("underlying", "uint32_t"),
            is_flags=is_flags,
            case=cpp.get("case", "pascal"),
            values=values,
        ),
        "lua": lua_block(meta.get("lua"), source_name, is_flags, values),
    }


def emit_table_enum(yaml_path: Path) -> dict[str, Any] | None:
    """Same return shape as `emit_pure_enum`. Returns None when the file has no `meta.enum:` block."""
    with yaml_path.open(encoding="utf-8") as f:
        doc = yaml.load(f, Loader=FastLoader)

    if not isinstance(doc, dict):
        return None
    meta_enum = (doc.get("meta") or {}).get("enum")
    if not meta_enum:
        return None

    section_name = meta_enum.get("section") or yaml_path.stem
    section = doc.get(section_name) or {}
    if not section:
        raise ValueError(f"{yaml_path}: no '{section_name}' section to derive enum from")

    values = derive_values(yaml_path, section, meta_enum.get("name_from"))

    cpp = meta_enum.get("cpp") or {}
    cls_name = cpp["class"]
    source_name = str(yaml_path.relative_to(ENUMS_DIR.parents[1])).replace("\\", "/")
    return {
        "name": pascal_to_snake(cls_name),
        "values": values,
        "source_name": source_name,
        "header": render_header(
            source_name=source_name,
            cls_name=cls_name,
            underlying=cpp.get("underlying", "uint32_t"),
            is_flags=False,
            case=cpp.get("case", "pascal"),
            values=values,
        ),
        "lua": lua_block(meta_enum.get("lua"), source_name, False, values),
    }


def derive_values(yaml_path: Path, section: dict[str, Any], name_from: str | None) -> dict[str, int]:
    """
    Returns {enum_name: int_value} from a YAML section.

    If `name_from` is set, YAML keys are the int ids and the enum name is slugged from the
    string at that dotpath (e.g. `name.en`). Otherwise the YAML key is the enum name and the
    int comes from the entry's `id:` field, or from the key itself if it's already an integer.
    """
    if not name_from:
        values: dict[str, int] = {}
        for key, entry in section.items():
            if isinstance(entry, dict) and "id" in entry:
                values[str(key)] = int(entry["id"])
                continue
            try:
                values[str(key)] = int(key)
            except (TypeError, ValueError):
                raise ValueError(f"{yaml_path}: entry '{key}' has no id: field and the key is not an integer")
        return values

    slug_to_ids: dict[str, list[int]] = {}
    for key, entry in section.items():
        raw = dotpath_get(entry, name_from) if isinstance(entry, dict) else None
        if not isinstance(raw, str):
            raise ValueError(f"{yaml_path}: entry {key!r} has no string at {name_from}")
        s = slug(raw)
        if not s:
            raise ValueError(f"{yaml_path}: entry {key!r} slugged to empty from {raw!r}")
        slug_to_ids.setdefault(s, []).append(int(key))

    out: dict[str, int] = {}
    for s, ids in slug_to_ids.items():
        if len(ids) == 1:
            out[s] = ids[0]
        else:
            for i in ids:
                out[f"{s}_{i}"] = i
    return out
