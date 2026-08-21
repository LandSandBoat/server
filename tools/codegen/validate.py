import json
import sys
from pathlib import Path
from typing import Any

from jsonschema import Draft202012Validator
from ruamel.yaml import YAML
from ruamel.yaml.comments import CommentedMap, CommentedSeq

from .common import ENUMS_DIR, ROOT

YAML_LOADER = YAML(typ="rt")
MAX_ERRORS = 50


def node_line(root: Any, path: list[str | int]) -> int:
    """Return the closest source line available for a validation path."""
    node = root
    line = 0
    for step in path:
        try:
            if isinstance(node, CommentedMap):
                line = node.lc.key(step)[0]
            elif isinstance(node, CommentedSeq):
                line = node.lc.item(step)[0]
            node = node[step]
        except (IndexError, KeyError, TypeError):
            break
    return line + 1


def validation_path(path: list[str | int]) -> str:
    """Format a validation path for a human-readable error."""
    return ".".join(str(step) for step in path) or "<root>"


def validation_message(error: Any) -> str:
    """Pick the deepest useful error from an anyOf or oneOf failure."""
    while error.context:
        error = max(error.context, key=lambda nested: len(nested.absolute_path))
    if error.validator == "enum":
        title = error.schema.get("title") if isinstance(error.schema, dict) else None
        return f"{error.instance!r} is not a valid {title or 'enum value'}"
    return error.message if len(error.message) <= 200 else error.message[:200] + " ..."


def validate_data_yamls(schemas_dir: Path) -> None:
    """Validate every non-enum data YAML against its matching schema."""
    registry = build_registry(schemas_dir)

    # A data file is matched to its schema by filename, so per-zone files such as
    # data/zones/<zone>/zone.yaml all validate against data/schemas/zone.schema.json.
    schemas: dict[str, tuple[Path, Any]] = {}
    for schema_path in sorted(schemas_dir.glob("*.schema.json")):
        with schema_path.open(encoding="utf-8") as f:
            schemas[schema_path.stem.removesuffix(".schema")] = (schema_path, json.load(f))

    # Every non-enum data file needs a schema.
    schema_by_data: dict[Path, Any] = {}
    for data_path in sorted((ROOT / "data").rglob("*.yaml")):
        if data_path.is_relative_to(ENUMS_DIR):
            continue

        match = schemas.get(data_path.stem)
        if match is None:
            raise SystemExit(
                f"{data_path.relative_to(ROOT).as_posix()}: no schema in data/schemas, so nothing validates it"
            )
        schema_by_data[data_path] = match[1]

    all_errors: list[tuple[Path, int, Any]] = []
    for data_path, schema in sorted(schema_by_data.items()):
        rel = data_path.relative_to(ROOT).as_posix()
        print(f"validating {rel} ...", end="", flush=True)
        with data_path.open(encoding="utf-8") as f:
            data = YAML_LOADER.load(f)

        validator = Draft202012Validator(schema, registry=registry)
        errs = [
            (data_path, node_line(data, list(error.absolute_path)), error)
            for error in validator.iter_errors(data)
        ]
        if errs:
            print(f" {len(errs)} errors", flush=True)
            all_errors.extend(errs)
        else:
            print(" ok", flush=True)

    if all_errors:
        print(f"\n{len(all_errors)} validation errors", file=sys.stderr)
        for data_path, line, error in all_errors[:MAX_ERRORS]:
            path = validation_path(list(error.absolute_path))
            print(
                f"{data_path.resolve()}:{line}: {path}: {validation_message(error)}",
                file=sys.stderr,
            )
        if len(all_errors) > MAX_ERRORS:
            print(f"... and {len(all_errors) - MAX_ERRORS} more", file=sys.stderr)
        raise SystemExit(1)


def build_registry(schemas_dir: Path) -> Any:
    """Validate and register every schema by its local filename."""
    from referencing import Registry, Resource
    from referencing.jsonschema import DRAFT202012

    reg = Registry()
    for p in schemas_dir.glob("*.schema.json"):
        with p.open(encoding="utf-8") as f:
            doc = json.load(f)
        Draft202012Validator.check_schema(doc)
        reg = reg.with_resource(
            uri=p.name, resource=Resource(contents=doc, specification=DRAFT202012)
        )
    return reg
