from pathlib import Path
from typing import Any

from ruamel.yaml import YAML

from .common import (
    CASE_FNS,
    ENUMS_DIR,
    ENV,
    ROOT,
    dotpath_get,
    pascal_to_snake,
    slug,
    snake_to_pascal,
)

YAML_LOADER = YAML(typ="safe")


def render_header(*, source_name: str, cls_name: str, underlying: str, is_flags: bool, case: str, values: dict[str, int]) -> str:
    if case not in CASE_FNS:
        raise ValueError(f"unknown enum case {case!r}; expected one of {sorted(CASE_FNS)}")
    cpp_names = {name: CASE_FNS[case](name) for name in values}
    return ENV.get_template("enum.h.j2").render(
        source_name=source_name,
        cls_name=cls_name,
        underlying=underlying,
        is_flags=is_flags,
        values=values,
        cpp_names=cpp_names,
        enum_width=max(len(cpp_name) for cpp_name in cpp_names.values()),
        quote_width=max(len(name) for name in values) + 2,
    )


def render_lua(*, source_name: str, lua_table: str, is_flags: bool, values: dict[str, int]) -> str:
    """Identifiers are the YAML key uppercased: `no_erase` -> `NO_ERASE`."""
    lua_names = {name: name.upper() for name in values}
    return ENV.get_template("enum.lua.j2").render(
        source_name=source_name,
        lua_table=lua_table,
        is_flags=is_flags,
        values=values,
        lua_names=lua_names,
        name_width=max(len(lua_name) for lua_name in lua_names.values()),
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
        doc = YAML_LOADER.load(f)

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


def resolve_sections(doc: dict[str, Any], path: str) -> list[dict[str, Any]]:
    """Every section the path names; `*` steps through all entries at that level (`ecosystems.*.families`)."""
    nodes: list[dict[str, Any]] = [doc]
    for part in path.split("."):
        next_nodes: list[dict[str, Any]] = []
        for node in nodes:
            if part == "*":
                next_nodes.extend(child for child in node.values() if isinstance(child, dict))
            else:
                child = node.get(part)
                if isinstance(child, dict):
                    next_nodes.append(child)

        nodes = next_nodes
    return nodes


def union_into(target: Any, patch: Any) -> None:
    """Add whatever `patch` has and `target` lacks, recursing into mappings.

    Never removes: an entry one module deletes still exists for the others.
    """
    if not isinstance(patch, dict) or not isinstance(target, dict):
        return

    for key, value in patch.items():
        if value is None:
            continue

        if isinstance(value, dict):
            target.setdefault(key, {})
            union_into(target[key], value)
        elif key not in target:
            target[key] = value


def module_copies(yaml_path: Path) -> list[Path]:
    """Every module's copy of this data file, enabled or not."""
    return sorted(ROOT.glob(f"modules/*/data/{yaml_path.name}"))


def emit_table_enums(yaml_path: Path) -> list[dict[str, Any]]:
    """One entry per `meta.enum:` block. Members emit in id order."""
    with yaml_path.open(encoding="utf-8") as f:
        doc = YAML_LOADER.load(f)

    for module_path in module_copies(yaml_path):
        with module_path.open(encoding="utf-8") as f:
            union_into(doc, YAML_LOADER.load(f))

    if not isinstance(doc, dict):
        return []
    meta_enum = (doc.get("meta") or {}).get("enum")
    if not meta_enum:
        return []

    with yaml_path.open(encoding="utf-8") as f:
        core_doc = YAML_LOADER.load(f)

    source_name = str(yaml_path.relative_to(ENUMS_DIR.parents[1])).replace("\\", "/")
    out: list[dict[str, Any]] = []
    for block in meta_enum:
        path = block.get("section") or yaml_path.stem
        sections = resolve_sections(doc, path)
        if not sections:
            raise ValueError(f"{yaml_path}: section path '{path}' matched nothing")

        values: dict[str, int] = {}
        for section in sections:
            for key, value in derive_values(yaml_path, section, block.get("name_from")).items():
                if key in values:
                    raise ValueError(f"{yaml_path}: '{path}' yields duplicate key '{key}' "
                                     f"(ids {values[key]} and {value}); keys must be unique across the tree")
                values[key] = value

        # Names this file defines, before any module is folded in.
        own: dict[str, int] = {}
        for section in resolve_sections(core_doc, path):
            own.update(derive_values(yaml_path, section, block.get("name_from")))

        names_by_id: dict[int, list[str]] = {}
        for name, value in values.items():
            names_by_id.setdefault(value, []).append(name)

        # Modules that never run together can reuse a slot, so only a collision inside this file is a mistake.
        collisions = {value: names for value, names in names_by_id.items()
                      if len([name for name in names if name in own]) > 1}
        if collisions:
            raise ValueError(f"{yaml_path}: '{path}' reuses ids across entries: "
                             + "; ".join(f"{value} -> {names}" for value, names in sorted(collisions.items())))

        values = dict(sorted(values.items(), key=lambda name_and_value: name_and_value[1]))

        cpp = block.get("cpp") or {}
        cls_name = cpp["class"]
        out.append({
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
            "lua": lua_block(block.get("lua"), source_name, False, values),
        })
    return out


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
