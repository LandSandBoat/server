import json
import re
import sys
import time
from collections import defaultdict
from pathlib import Path
from typing import Any

import yaml
from jsonschema import Draft202012Validator

from .common import ROOT
from .yaml_loaders import LineLoader, node_line


def validate_data_yamls(schemas_dir: Path, keyset_dir: Path, build_root: Path) -> None:
    """Per-file stamps under <build>/generated/.validated.<name>.stamp skip yamls that haven't changed."""
    registry = build_registry(schemas_dir, keyset_dir)
    schema_side_mtime = max(
        (
            p.stat().st_mtime
            for p in [
                Path(__file__),
                *schemas_dir.glob("*.schema.json"),
                *schemas_dir.glob("_*.schema.json"),
                *keyset_dir.glob("*.codegen.json"),
            ]
        ),
        default=0.0,
    )

    all_errors: list[tuple[Path, int, Any]] = []
    root_by_file: dict[Path, Any] = {}
    for schema_path in sorted(schemas_dir.glob("*.schema.json")):
        data_path = ROOT / "data" / f"{schema_path.stem.removesuffix('.schema')}.yaml"
        if not data_path.exists():
            continue
        stamp = build_root / "generated" / f".validated.{data_path.stem}.stamp"
        if stamp.exists() and data_path.stat().st_mtime <= stamp.stat().st_mtime and schema_side_mtime <= stamp.stat().st_mtime:
            continue

        rel = data_path.relative_to(ROOT).as_posix()
        print(f"validating {rel} ...", end="", flush=True)
        with schema_path.open(encoding="utf-8") as f:
            schema = json.load(f)
        with data_path.open(encoding="utf-8") as f:
            data = yaml.load(f, Loader=LineLoader)
        root_by_file[data_path] = data

        start = time.monotonic()
        validator = Draft202012Validator(schema, registry=registry)
        errs = [(data_path, node_line(data, list(e.absolute_path)), e) for e in validator.iter_errors(data)]
        elapsed_ms = int((time.monotonic() - start) * 1000)
        if errs:
            print(f" {len(errs)} errors ({elapsed_ms} ms)", flush=True)
            all_errors.extend(errs)
        else:
            print(f" ok ({elapsed_ms} ms)", flush=True)
            stamp.parent.mkdir(parents=True, exist_ok=True)
            stamp.touch()

    if all_errors:
        print_errors(all_errors, root_by_file)
        sys.exit(1)


def build_registry(schemas_dir: Path, keyset_dir: Path) -> Any:
    from referencing import Registry, Resource
    from referencing.jsonschema import DRAFT202012

    reg = Registry()
    for p in keyset_dir.glob("*.codegen.json"):
        with p.open(encoding="utf-8") as f:
            doc = json.load(f)
        reg = reg.with_resource(uri=f"enums/{p.name}", resource=Resource(contents=doc, specification=DRAFT202012))
    for p in schemas_dir.glob("_*.schema.json"):
        with p.open(encoding="utf-8") as f:
            doc = json.load(f)
        reg = reg.with_resource(uri=p.name, resource=Resource(contents=doc, specification=DRAFT202012))
    return reg


def entity_context(root: Any, absolute_path: list[Any]) -> str | None:
    if not isinstance(root, dict) or len(absolute_path) < 2:
        return None
    section, key = str(absolute_path[0]), absolute_path[1]
    section_node = root.get(section)
    if not isinstance(section_node, dict):
        return None
    label = f"{section}[{key}]" if isinstance(key, int) else f"{section}.{key}"
    entity = section_node.get(key)
    if isinstance(entity, dict):
        name = entity.get("name")
        if isinstance(name, dict):
            name = name.get("en")
        if isinstance(name, str) and name:
            label += f" {name}"
    return label


def norm_path(absolute_path: list[Any]) -> str:
    """List indices collapse to [*] so identical errors across 14k rows group into one."""
    parts: list[str] = []
    for p in absolute_path:
        if isinstance(p, int):
            parts.append("[*]")
        else:
            if parts:
                parts.append(".")
            parts.append(str(p))
    return "".join(parts) or "<root>"


_REQUIRED_RE = re.compile(r"'([^']+)' is a required property")


def short_error(err: Any) -> str:
    v = err.validator
    if v == "enum":
        sid = err.schema.get("$id", "") if isinstance(err.schema, dict) else ""
        if sid.startswith("enums/") and sid.endswith(".codegen.json"):
            return f"value {err.instance!r} is not a valid {sid[len('enums/'):-len('.codegen.json')]}"
        return f"value {err.instance!r} not in enum"
    if v == "type":
        got = "null" if err.instance is None else type(err.instance).__name__
        return f"expected {err.validator_value}, got {got}"
    if v == "required":
        m = _REQUIRED_RE.search(err.message)
        return f"missing required field {m.group(1)!r}" if m else err.message
    if v == "oneOf":
        return explain_oneof(err)
    if v == "unevaluatedProperties":
        return err.message
    return err.message if len(err.message) <= 160 else err.message[:160] + " ..."


def explain_oneof(err: Any) -> str:
    inst = err.instance if isinstance(err.instance, dict) else None
    type_value = inst.get("type") if inst else None
    if not type_value:
        return "no oneOf branch matched (missing 'type' field)"

    branch_idx = None
    for i, branch in enumerate(err.schema.get("oneOf", [])):
        tp = branch.get("properties", {}).get("type", {})
        if tp.get("const") == type_value or type_value in (tp.get("enum") or []):
            branch_idx = i
            break
    if branch_idx is None:
        return f"type={type_value!r} not allowed by any oneOf branch"

    branch_errs = [e for e in err.context if e.schema_path and e.schema_path[0] == branch_idx]
    if not branch_errs:
        return f"type={type_value!r}: matched but no detail"

    deepest = max(branch_errs, key=lambda e: len(e.absolute_path))
    if deepest.validator == "type" and deepest.instance is None and deepest.absolute_path:
        return f"type={type_value!r} but '{deepest.absolute_path[-1]}:' block is null (expected fields)"
    if deepest.validator == "required":
        m = _REQUIRED_RE.search(deepest.message)
        if m:
            return f"type={type_value!r} but '{m.group(1)}:' block is missing"
    return f"type={type_value!r}: {short_error(deepest)}"


def print_errors(all_errors: list[tuple[Path, int, Any]], root_by_file: dict[Path, Any]) -> None:
    """Suppress type errors paired with an enum error (same cause); same for unevaluatedProperties paired with oneOf."""
    suppress_type: set[tuple[Path, tuple[Any, ...]]] = set()
    suppress_uneval: set[tuple[Path, tuple[Any, ...]]] = set()
    for fpath, _line, err in all_errors:
        loc = (fpath, tuple(err.absolute_path))
        if err.validator == "enum":
            suppress_type.add(loc)
        elif err.validator == "oneOf":
            suppress_uneval.add(loc)

    groups: dict[tuple[Path, str, str], list[tuple[int, Any]]] = defaultdict(list)
    for fpath, line, err in all_errors:
        loc = (fpath, tuple(err.absolute_path))
        if err.validator == "type" and loc in suppress_type:
            continue
        if err.validator == "unevaluatedProperties" and loc in suppress_uneval:
            continue
        groups[(fpath, norm_path(err.absolute_path), err.validator)].append((line, err))

    total = sum(len(v) for v in groups.values())
    by_file: dict[Path, list[tuple[str, str, list[tuple[int, Any]]]]] = defaultdict(list)
    for (fpath, npath, validator), items in groups.items():
        by_file[fpath].append((npath, validator, items))

    print(f"\n{total} errors, {len(groups)} patterns", file=sys.stderr)

    for fpath, entries in sorted(by_file.items(), key=lambda kv: kv[0].name):
        abs_path = str(fpath.resolve())
        root = root_by_file.get(fpath)
        print(f"\n  {abs_path}", file=sys.stderr)
        entries.sort(key=lambda e: (e[0], e[1]))
        for npath, _validator, items in entries:
            lead_line, lead_err = items[0]
            print(f"\n    [{len(items):>4}]  {npath}", file=sys.stderr)
            print(f"            {short_error(lead_err)}", file=sys.stderr)
            ctx = entity_context(root, list(lead_err.absolute_path)) or ""
            print(f"            {abs_path}:{lead_line}:1   {ctx}", file=sys.stderr)
            for ln, err2 in items[1:3]:
                ctx2 = entity_context(root, list(err2.absolute_path)) or ""
                print(f"            {abs_path}:{ln}:1   {ctx2}", file=sys.stderr)
            if len(items) > 3:
                print(f"            ... and {len(items) - 3} more", file=sys.stderr)
