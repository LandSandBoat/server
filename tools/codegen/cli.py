import argparse
from pathlib import Path

from .common import ENUMS_DIR, ROOT, TEMPLATES_DIR, write_if_changed
from .enum_codegen import emit_pure_enum, emit_table_enums
from .validate import validate_data_yamls


def enum_inputs_newer_than(stamp: Path) -> bool:
    if not stamp.exists():
        return True
    stamp_mtime = stamp.stat().st_mtime
    inputs = [
        *Path(__file__).parent.glob("*.py"),
        *TEMPLATES_DIR.glob("*.j2"),
        *(ROOT / "data").rglob("*.yaml"),
        *ROOT.glob("modules/*/data/*.yaml"),
    ]
    return any(input_path.stat().st_mtime > stamp_mtime for input_path in inputs)


def main():
    """Rendering is skipped while the stamp is newer than every input; `--validate` always runs."""
    parser = argparse.ArgumentParser()
    parser.add_argument("build_dir")
    parser.add_argument(
        "--validate",
        action="store_true",
        help="Also run schema validation.",
    )
    args = parser.parse_args()

    build_root = Path(args.build_dir)
    schemas_dir = ROOT / "data" / "schemas"
    stamp = build_root / "generated" / ".enum_codegen.stamp"
    if not enum_inputs_newer_than(stamp):
        if args.validate:
            validate_data_yamls(schemas_dir)
        return

    out_dir = build_root / "generated" / "data" / "enums"
    lua_out_dir = ROOT / "scripts" / "enum"
    for directory in (out_dir, lua_out_dir):
        directory.mkdir(parents=True, exist_ok=True)

    # Enums: pure (data/enums/*.yaml) + table-derived (meta.enum: inside a data file).
    enums: list[dict] = []
    for enum_path in sorted(ENUMS_DIR.glob("*.yaml")):
        enums.append(emit_pure_enum(enum_path))
    for data_path in sorted((ROOT / "data").rglob("*.yaml")):
        if data_path.is_relative_to(ENUMS_DIR):
            continue

        print(f"scanning {data_path.relative_to(ROOT).as_posix()} for embedded enums ...", flush=True)
        enums.extend(emit_table_enums(data_path))

    for enum in enums:
        write_if_changed(out_dir / (enum["name"] + ".h"), enum["header"])
        if enum["lua"]:
            write_if_changed(lua_out_dir / (enum["lua"]["name"] + ".codegen.lua"), enum["lua"]["content"])

    stamp.parent.mkdir(parents=True, exist_ok=True)
    stamp.touch()

    if args.validate:
        validate_data_yamls(schemas_dir)


if __name__ == "__main__":
    main()
