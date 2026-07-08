import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Literal

import yaml
from jsonschema import Draft202012Validator, exceptions as jsonschema_exceptions

from .common import CASE_FNS, ENUMS_DIR, ENV, ROOT, snake_to_pascal
from .yaml_loaders import FastLoader


PopulatorKind = Literal["scalar", "enum_ref", "bitflags", "enum_list", "record", "record_list"]


@dataclass(slots=True)
class Field:
    """`populator` drives the template dispatch. enum_* set on enum_ref/bitflags/enum_list; defs_*/struct_* on record/record_list."""

    yaml_name: str
    cpp_name: str
    cpp_type: str
    populator: PopulatorKind
    enum_name: str = ""
    enum_class: str = ""
    defs_name: str = ""
    struct_name: str = ""
    default: str = ""  # C++-literal form of schema `default`, empty when not declared.


class SchemaWalker:
    """One instance per codegen run; caches each enum YAML lookup so we open the file at most once."""

    def __init__(self) -> None:
        self.enum_cls_cache: dict[str, str] = {}
        self.enum_flags_cache: dict[str, bool] = {}
        self.enum_case_cache: dict[str, str] = {}

    def _load_enum_meta(self, name: str) -> dict[str, Any]:
        yaml_path = ENUMS_DIR / f"{name}.yaml"
        if not yaml_path.exists():
            return {}
        with yaml_path.open(encoding="utf-8") as f:
            return (yaml.load(f, Loader=FastLoader) or {}).get("meta") or {}

    def enum_is_flags(self, name: str) -> bool:
        if name not in self.enum_flags_cache:
            self.enum_flags_cache[name] = bool(self._load_enum_meta(name).get("flags", False))
        return self.enum_flags_cache[name]

    def enum_case(self, name: str) -> str:
        if name not in self.enum_case_cache:
            self.enum_case_cache[name] = (self._load_enum_meta(name).get("cpp") or {}).get("case", "pascal")
        return self.enum_case_cache[name]

    def enum_default(self, enum_name: str, cls: str, value: str) -> str:
        case_fn = CASE_FNS.get(self.enum_case(enum_name), snake_to_pascal)
        return f"xi::{cls}::{case_fn(value)}"

    def enum_ref_to_class(self, ref: str) -> tuple[str, str]:
        """`enums/item_flag.codegen.json` -> `("item_flag", "ItemFlag")`. Honors meta.cpp.class when set."""
        enum_name = ref.rsplit("/", 1)[-1].replace(".codegen.json", "")
        if enum_name not in self.enum_cls_cache:
            yaml_path = ENUMS_DIR / f"{enum_name}.yaml"
            cls: str | None = None
            if yaml_path.exists():
                with yaml_path.open(encoding="utf-8") as f:
                    doc = yaml.load(f, Loader=FastLoader) or {}
                cls = ((doc.get("meta") or {}).get("cpp") or {}).get("class")
            self.enum_cls_cache[enum_name] = cls or snake_to_pascal(enum_name)
        return enum_name, self.enum_cls_cache[enum_name]

    @staticmethod
    def defs_ref_to_struct(ref: str) -> tuple[str, str]:
        """`#/$defs/item_weapon` -> `("item_weapon", "ItemWeaponData")`"""
        defs_name = ref.rsplit("/", 1)[-1]
        return defs_name, snake_to_pascal(defs_name) + "Data"

    @staticmethod
    def int_cpp_type(schema: dict[str, Any]) -> str:
        """Narrowest C++ int type that covers [minimum, maximum]."""
        lo, hi = schema.get("minimum"), schema.get("maximum")
        if lo is not None and lo < 0:
            if lo >= -128 and hi is not None and hi <= 127:
                return "int8"
            if lo >= -32768 and hi is not None and hi <= 32767:
                return "int16"
            return "int32"
        if hi is not None and hi <= 255:
            return "uint8"
        if hi is not None and hi <= 65535:
            return "uint16"
        return "uint32"

    @staticmethod
    def scalar_default(schema: dict[str, Any]) -> str:
        """Format the schema's `default` as a C++ literal. Empty string when no default is declared."""
        if "default" not in schema:
            return ""
        v = schema["default"]
        if isinstance(v, bool):
            return "true" if v else "false"
        if isinstance(v, (int, float)):
            return str(v)
        if isinstance(v, str):
            return f'"{v}"'
        return ""

    def field_from_schema(self, name: str, schema: dict[str, Any]) -> Field:
        cpp_name = snake_to_pascal(name)

        ref = schema.get("$ref")
        if ref and ref.startswith("enums/"):
            enum_name, cls = self.enum_ref_to_class(ref)
            default = self.enum_default(enum_name, cls, schema["default"]) if isinstance(schema.get("default"), str) else ""
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"xi::{cls}",
                         populator="enum_ref", enum_name=enum_name, enum_class=cls, default=default)
        if ref and ref.startswith("#/$defs/"):
            defs_name, struct = self.defs_ref_to_struct(ref)
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=struct,
                         populator="record", defs_name=defs_name, struct_name=struct)

        items = schema.get("items") if schema.get("type") == "array" else None
        if isinstance(items, dict) and "$ref" in items:
            iref = items["$ref"]
            if iref.startswith("enums/"):
                enum_name, cls = self.enum_ref_to_class(iref)
                if self.enum_is_flags(enum_name):
                    # Flag enums collapse to a single OR'd value, not a list.
                    default = self.enum_default(enum_name, cls, schema["default"]) if isinstance(schema.get("default"), str) else ""
                    return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"xi::{cls}",
                                 populator="bitflags", enum_name=enum_name, enum_class=cls, default=default)
                return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"std::vector<xi::{cls}>",
                             populator="enum_list", enum_name=enum_name, enum_class=cls)
            if iref.startswith("#/$defs/"):
                defs_name, struct = self.defs_ref_to_struct(iref)
                return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"std::vector<{struct}>",
                             populator="record_list", defs_name=defs_name, struct_name=struct)

        t = schema.get("type")
        default = self.scalar_default(schema)
        if t == "integer":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=self.int_cpp_type(schema), populator="scalar", default=default)
        if t == "number":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="float", populator="scalar", default=default)
        if t == "boolean":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="bool", populator="scalar", default=default)
        if t == "string":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="std::string", populator="scalar", default=default)

        raise ValueError(f"unsupported property '{name}' schema: {schema}")

    def variant_arms_from_oneof(self, one_of: list[dict[str, Any]]) -> list[dict[str, Any]]:
        """Bodyless arm when the branch has no `required`; otherwise `required[0]` names the body field whose `$ref` points at the subtype `$defs`."""
        arms: list[dict[str, Any]] = []
        for branch in one_of:
            props = branch.get("properties") or {}
            type_prop = props.get("type") or {}
            required = branch.get("required") or []
            type_values = [type_prop["const"]] if "const" in type_prop else type_prop.get("enum", [])

            if not required:
                for tv in type_values:
                    arms.append(
                        {"type_value": tv, "cpp_name": snake_to_pascal(tv), "yaml_key": None, "struct_name": None,
                         "defs_name": None})
                continue

            yaml_key = required[0]
            body_schema = props.get(yaml_key) or {}
            if "$ref" not in body_schema:
                raise ValueError(f"oneOf branch's '{yaml_key}' is not a $ref to $defs")
            defs_name, struct = self.defs_ref_to_struct(body_schema["$ref"])
            for tv in type_values:
                arms.append(
                    {"type_value": tv, "cpp_name": snake_to_pascal(tv), "yaml_key": yaml_key, "struct_name": struct,
                     "defs_name": defs_name})
        return arms

    @staticmethod
    def find_main_defs(schema: dict[str, Any]) -> str | None:
        """The main record's `$defs` key: the section's `additionalProperties.$ref`, or the lone `$defs` entry if there's only one."""
        section_schema = next(
            (s for s in (schema.get("properties") or {}).values() if
             isinstance(s, dict) and "additionalProperties" in s),
            None,
        )
        if section_schema:
            addl = section_schema["additionalProperties"]
            if isinstance(addl, dict) and "$ref" in addl:
                return SchemaWalker.defs_ref_to_struct(addl["$ref"])[0]
        defs = schema.get("$defs") or {}
        return next(iter(defs.keys())) if len(defs) == 1 else None

    def emit(self, schema_path: Path) -> dict[str, Any] | None:
        """Returns None when the schema has no main `$defs` (e.g. shared _meta). Sub-PODs emit before the main one so it can reference them."""
        with schema_path.open(encoding="utf-8") as f:
            schema = json.load(f)

        try:
            Draft202012Validator.check_schema(schema)
        except jsonschema_exceptions.SchemaError as e:
            raise SystemExit(f"{schema_path.relative_to(ROOT)}: not a valid JSON Schema 2020-12: {e.message}")

        defs = schema.get("$defs") or {}
        main_name = self.find_main_defs(schema) if defs else None
        if not main_name or main_name not in defs:
            return None

        name = schema_path.stem.replace(".schema", "")
        source = str(schema_path.relative_to(ROOT)).replace("\\", "/")

        pods: list[dict[str, Any]] = []
        main_pod: dict[str, Any] | None = None
        for defs_name in [n for n in defs if n != main_name] + [main_name]:
            props = defs[defs_name].get("properties") or {}
            fields = [self.field_from_schema(name, fs) for name, fs in props.items()]
            pod = {
                "struct_name": snake_to_pascal(defs_name) + "Data",
                "fields": fields,
                "required": set(defs[defs_name].get("required") or []),
                "cpp_type_width": max((len(f.cpp_type) for f in fields), default=0),
                "is_main": defs_name == main_name,
                "variant_arms": [],
                "discriminator_field": None,
                "discriminator_enum": None,
            }
            if pod["is_main"]:
                main_pod = pod
            pods.append(pod)

        one_of = defs[main_name].get("oneOf")
        if one_of and main_pod is not None:
            main_pod["variant_arms"] = self.variant_arms_from_oneof(one_of)
            disc = next((f for f in main_pod["fields"] if f.populator == "enum_ref"), None)
            if disc is not None:
                main_pod["discriminator_field"] = disc.cpp_name
                main_pod["discriminator_enum"] = disc.enum_class

        # id: on the record => driver reads it; otherwise the YAML key is the integer id.
        has_id_field = any(f.yaml_name == "id" for f in main_pod["fields"])
        main_pod["key_source"] = "yaml_field" if has_id_field else "yaml_key"
        if main_pod["key_source"] == "yaml_key":
            main_pod["fields"].insert(0, Field(yaml_name="id", cpp_name="Id", cpp_type="uint16", populator="scalar"))
            main_pod["cpp_type_width"] = max(len(f.cpp_type) for f in main_pod["fields"])

        main_pod["name_default_from_key"] = main_pod["key_source"] == "yaml_field" and any(
            f.yaml_name == "name" for f in main_pod["fields"])

        enum_includes = {f.enum_name for pod in pods for f in pod["fields"] if f.enum_name}

        ctx = dict(
            source=source,
            name=name,
            section_name=name,
            main_pod=main_pod,
            pods=pods,
            enum_includes=sorted(enum_includes),
        )
        return {
            "name": name,
            "pod": ENV.get_template("data_pod.h.j2").render(**ctx),
            "populator": ENV.get_template("data_populator.h.j2").render(**ctx),
        }
