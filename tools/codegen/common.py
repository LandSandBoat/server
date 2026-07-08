import re
from pathlib import Path
from typing import Any, Callable

from jinja2 import Environment, FileSystemLoader, StrictUndefined

ROOT: Path = Path(__file__).resolve().parents[2]
ENUMS_DIR: Path = ROOT / "data" / "enums"
TEMPLATES_DIR: Path = Path(__file__).resolve().parent / "templates"

ENV: Environment = Environment(
    loader=FileSystemLoader(TEMPLATES_DIR),
    undefined=StrictUndefined,
    trim_blocks=True,
    lstrip_blocks=True,
    keep_trailing_newline=True,
)


def snake_to_pascal(s: str) -> str:
    """status_effect_flag -> StatusEffectFlag"""
    return "".join(part.capitalize() for part in s.split("_") if part)


def pascal_to_snake(s: str) -> str:
    """StatusEffectFlag -> status_effect_flag"""
    return re.sub(r"(?<!^)(?=[A-Z])", "_", s).lower()


CASE_FNS: dict[str, Callable[[str], str]] = {
    "pascal": snake_to_pascal,
    "screaming": str.upper,
}

_SLUG_PLUS = re.compile(r"\+(\d+)")
_SLUG_MINUS = re.compile(r"-(\d+)")
_SLUG_STRIP = re.compile(r"[\"',.():?!&/]")
_SLUG_SEP = re.compile(r"[\s\-_]+")
_SLUG_REST = re.compile(r"[^a-z0-9_]")


def slug(s: str) -> str:
    s = s.lower()
    s = _SLUG_PLUS.sub(r"p\1", s)
    s = _SLUG_MINUS.sub(r"m\1", s)
    s = _SLUG_STRIP.sub("", s)
    s = _SLUG_SEP.sub("_", s)
    s = _SLUG_REST.sub("", s)
    s = re.sub(r"__+", "_", s).strip("_")
    if s and s[0].isdigit():
        s = "i_" + s
    return s


def dotpath_get(d: dict[str, Any], path: str) -> Any:
    """`name.en` -> d["name"]["en"]"""
    cur: Any = d
    for part in path.split("."):
        cur = cur.get(part) if isinstance(cur, dict) else None
        if cur is None:
            return None
    return cur


def write_if_changed(path: Path, content: str) -> None:
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return
    path.write_text(content, encoding="utf-8")
    print(f"wrote {path}")

