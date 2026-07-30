import json
from functools import cache
from graphlib import TopologicalSorter
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Literal

import yaml
from jsonschema import Draft202012Validator, exceptions as jsonschema_exceptions

from .common import CASE_FNS, ENUMS_DIR, ENV, ROOT, snake_to_pascal
from .yaml_loaders import FastLoader


PopulatorKind = Literal["value", "record", "record_list", "record_map", "mixin",
                        "typed_id", "name_key"]


@dataclass(slots=True)
class Field:
    """`populator` drives the template dispatch. enum_* set on value; defs_*/struct_* on record/record_list/record_map."""

    yaml_name: str
    cpp_name: str
    cpp_type: str
    populator: PopulatorKind
    enum_name: str = ""
    enum_class: str = ""
    defs_name: str = ""
    struct_name: str = ""
    default: str = ""  # C++-literal form of schema `default`, empty when not declared.
    defs_source: str = ""  # stem of the shared schema, when the record came from one


@cache
def enum_meta(name: str) -> dict[str, Any]:
    """The `meta:` block of data/enums/<name>.yaml, empty when there is no such file."""
    yaml_path = ENUMS_DIR / f"{name}.yaml"
    if not yaml_path.exists():
        return {}

    with yaml_path.open(encoding="utf-8") as handle:
        return (yaml.load(handle, Loader=FastLoader) or {}).get("meta") or {}


class SchemaWalker:
    """Turns a data schema into the PODs and populators codegen emits."""

    @staticmethod
    def enum_is_flags(name: str) -> bool:
        return bool(enum_meta(name).get("flags", False))

    @staticmethod
    def enum_case(name: str) -> str:
        return (enum_meta(name).get("cpp") or {}).get("case", "pascal")

    @staticmethod
    def enum_default(enum_name: str, cls: str, value: str) -> str:
        case_fn = CASE_FNS.get(SchemaWalker.enum_case(enum_name), snake_to_pascal)
        return f"xi::{cls}::{case_fn(value)}"

    @staticmethod
    def enum_ref_to_class(ref: str) -> tuple[str, str]:
        """`enums/item_flag.codegen.json` -> `("item_flag", "ItemFlag")`. Honors meta.cpp.class when set."""
        enum_name = ref.rsplit("/", 1)[-1].removesuffix(".codegen.json")
        cls = (enum_meta(enum_name).get("cpp") or {}).get("class")
        return enum_name, cls or snake_to_pascal(enum_name)

    @staticmethod
    def load_schema(schema_path: Path) -> dict[str, Any]:
        """Parses a schema and rejects it if it is not valid JSON Schema 2020-12."""
        with schema_path.open(encoding="utf-8") as f:
            schema = json.load(f)

        try:
            Draft202012Validator.check_schema(schema)
        except jsonschema_exceptions.SchemaError as e:
            raise SystemExit(f"{schema_path.relative_to(ROOT)}: not a valid JSON Schema 2020-12: {e.message}")

        return schema

    @staticmethod
    def resolve_defs_ref(ref: str) -> tuple[str, str, str] | None:
        """`mob_attributes.schema.json#/$defs/stat_ranks` -> `("mob_attributes", "stat_ranks", "StatRanksData")`; None if not a $defs ref."""
        file_part, _, fragment = ref.partition("#")
        if not fragment.startswith("/$defs/"):
            return None

        defs_name = fragment.removeprefix("/$defs/")
        if "/" in defs_name:  # a ref into a record's internals is not a record
            return None

        return file_part.replace(".schema.json", ""), defs_name, snake_to_pascal(defs_name) + "Data"

    @staticmethod
    def source_of(schema_path: Path) -> str:
        """`data/schemas/mob_attributes.schema.json` -> `mob_attributes`, the name its headers get."""
        return schema_path.stem.replace(".schema", "")

    @staticmethod
    def overrides_name(struct: str) -> str:
        """`StatRanksData` -> `StatRanksOverrides`; only the suffix, so `DataTableData` survives."""
        return struct.removesuffix("Data") + "Overrides"

    @staticmethod
    def int_cpp_type(schema: dict[str, Any]) -> str:
        """Narrowest C++ int type that covers [minimum, maximum]."""
        minimum, maximum = schema.get("minimum"), schema.get("maximum")
        if minimum is not None and minimum < 0:
            if minimum >= -128 and maximum is not None and maximum <= 127:
                return "int8"
            if minimum >= -32768 and maximum is not None and maximum <= 32767:
                return "int16"
            return "int32"

        if maximum is not None and maximum <= 255:
            return "uint8"
        if maximum is not None and maximum <= 65535:
            return "uint16"
        return "uint32"

    @staticmethod
    def scalar_default(schema: dict[str, Any]) -> str:
        """Format the schema's `default` as a C++ literal. Empty string when no default is declared."""
        if "default" not in schema:
            return ""
        value = schema["default"]
        if isinstance(value, bool):
            return "true" if value else "false"
        if isinstance(value, (int, float)):
            return str(value)
        if isinstance(value, str):
            return f'"{value}"'
        return ""

    def field_from_schema(self, name: str, schema: dict[str, Any]) -> Field:
        cpp_name = snake_to_pascal(name)

        # A section nested inside a record: the same map-of-records the top level uses.
        if self.is_section(schema):
            _src, child_defs, struct = self.resolve_defs_ref(schema["additionalProperties"]["$ref"])
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"HashMap<decltype({struct}::Id), {struct}>",
                         populator="record_map", defs_name=child_defs, struct_name=struct)

        ref = schema.get("$ref")
        if ref and ref.startswith("enums/"):
            enum_name, cls = self.enum_ref_to_class(ref)
            default = self.enum_default(enum_name, cls, schema["default"]) if isinstance(schema.get("default"), str) else ""
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"xi::{cls}",
                         populator="value", enum_name=enum_name, enum_class=cls, default=default)
        record = self.resolve_defs_ref(ref) if ref else None
        if record:
            return self.record_field(name, cpp_name, record, is_list=False)

        items = schema.get("items") if schema.get("type") == "array" else None
        if isinstance(items, dict) and "$ref" in items:
            iref = items["$ref"]
            record = self.resolve_defs_ref(iref)
            if record:
                return self.record_field(name, cpp_name, record, is_list=True)
            if iref.startswith("enums/"):
                enum_name, cls = self.enum_ref_to_class(iref)
                if self.enum_is_flags(enum_name):
                    # Flag enums collapse to a single OR'd value, not a list.
                    default = self.enum_default(enum_name, cls, schema["default"]) if isinstance(schema.get("default"), str) else ""
                    return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"xi::{cls}",
                                 populator="value", enum_name=enum_name, enum_class=cls, default=default)
                return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=f"std::vector<xi::{cls}>",
                             populator="value", enum_name=enum_name, enum_class=cls)

        t = schema.get("type")
        default = self.scalar_default(schema)
        if t == "integer":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type=self.int_cpp_type(schema), populator="value", default=default)
        if t == "number":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="float", populator="value", default=default)
        if t == "boolean":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="bool", populator="value", default=default)
        if t == "string":
            return Field(yaml_name=name, cpp_name=cpp_name, cpp_type="std::string", populator="value", default=default)

        raise ValueError(f"unsupported property '{name}' schema: {schema}")

    @staticmethod
    def record_field(name: str, cpp_name: str, record: tuple[str, str, str], *, is_list: bool) -> Field:
        shared, defs_name, struct = record
        return Field(yaml_name=name, cpp_name=cpp_name,
                     cpp_type=f"std::vector<{struct}>" if is_list else struct,
                     populator="record_list" if is_list else "record",
                     defs_name=defs_name, struct_name=struct, defs_source=shared)

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
            record = self.resolve_defs_ref(body_schema.get("$ref", ""))
            if not record:
                raise ValueError(f"oneOf branch's '{yaml_key}' is not a $ref to $defs")

            _shared, defs_name, struct = record
            for tv in type_values:
                arms.append(
                    {"type_value": tv, "cpp_name": snake_to_pascal(tv), "yaml_key": yaml_key, "struct_name": struct,
                     "defs_name": defs_name})
        return arms

    @staticmethod
    def is_section(schema: dict[str, Any]) -> bool:
        """A map of records: `{ type: object, additionalProperties: { $ref: #/$defs/... } }`."""
        addl = schema.get("additionalProperties")
        return schema.get("type") == "object" and isinstance(addl, dict) and "$ref" in addl

    @staticmethod
    def first_section(props: dict[str, Any]) -> tuple[str, dict[str, Any]] | None:
        """The first `(key, schema)` in `props` that is a section, if any."""
        for prop_name, prop_schema in props.items():
            if isinstance(prop_schema, dict) and SchemaWalker.is_section(prop_schema):
                return prop_name, prop_schema

        return None

    def build_pod(self, defs_name: str, defs: dict[str, Any], *, own: str, partials: set[tuple[str, str]]) -> dict[str, Any]:
        """`allOf` entries are mixins: their keys sit on this record's node, so each becomes a contained struct."""
        schema = defs[defs_name]
        fields = []
        for entry in schema.get("allOf") or []:
            mixin = self.resolve_defs_ref(entry.get("$ref", ""))
            if not mixin:
                raise ValueError(f"{defs_name}: allOf entries must be a $ref to a $defs record")
            shared, mixin_name, struct = mixin
            partial = (shared or own, mixin_name) in partials
            fields.append(Field(yaml_name="", cpp_name=snake_to_pascal(mixin_name),
                                cpp_type=self.overrides_name(struct) if partial else struct,
                                populator="mixin", defs_name=mixin_name, struct_name=struct, defs_source=shared))

        props = schema.get("properties") or {}
        for prop_name, prop_schema in props.items():
            fields.append(self.field_from_schema(prop_name, prop_schema))
        return {
            "defs_name": defs_name,
            "struct_name": snake_to_pascal(defs_name) + "Data",
            "fields": fields,
            "cpp_type_width": max((len(field.cpp_type) for field in fields), default=0),
            "is_main": False,
            "variant_arms": [],
            "discriminator_field": None,
            "discriminator_enum": None,
        }

    def tree_levels(self, schema: dict[str, Any]) -> list[tuple[str, str]]:
        """The nesting spine outermost first, [(section key, $defs name), ...]; the last level is the record."""
        defs = schema.get("$defs") or {}
        node = self.first_section((schema.get("properties") or {}))

        levels: list[tuple[str, str]] = []
        while node:
            key, section = node
            defs_name = self.resolve_defs_ref(section["additionalProperties"]["$ref"])[1]
            levels.append((key, defs_name))
            props = (defs.get(defs_name) or {}).get("properties") or {}
            node = self.first_section(props)
        return levels

    def emit(self, schema_path: Path, schema: dict[str, Any], enum_names: set[str],
             partials: set[tuple[str, str]]) -> dict[str, Any] | None:
        """One POD per `$defs`. A file with a top-level section also gets the loop that reads it."""
        defs = schema.get("$defs") or {}
        if not defs:
            return None

        levels = self.tree_levels(schema)  # empty for a schema that only holds shared shapes
        depth_of: dict[str, int] = {}
        for depth, (_section, defs_name) in enumerate(levels):
            depth_of[defs_name] = depth

        own  = self.source_of(schema_path)
        pods: dict[str, dict[str, Any]] = {}
        for defs_name in defs:
            pod = self.build_pod(defs_name, defs, own=own, partials=partials)
            self.retype_ids(pod, defs_name, nested=len(levels) > 1, depth_of=depth_of, enum_names=enum_names)
            pods[defs_name] = pod

        # A struct held by value must be defined first, so emit dependencies before dependents.
        holds: dict[str, set[str]] = {}
        for defs_name, pod in pods.items():
            holds[defs_name] = {field.defs_name for field in pod["fields"]
                                if field.defs_name in pods and not field.defs_source}

        ordered = [pods[defs_name] for defs_name in TopologicalSorter(holds).static_order()]

        # A tree's main pod is its outermost level. A shared-shapes file uses whatever holds the rest.
        main_name = levels[0][1] if levels else ordered[-1]["defs_name"]
        for pod in pods.values():
            pod["is_main"] = pod["defs_name"] == main_name
        main_pod = pods[main_name]

        one_of = defs[main_name].get("oneOf")
        if one_of:
            main_pod["variant_arms"] = self.variant_arms_from_oneof(one_of)
            disc = next((field for field in main_pod["fields"] if field.enum_class and field.populator == "value"), None)
            if disc is not None:
                main_pod["discriminator_field"] = disc.cpp_name
                main_pod["discriminator_enum"] = disc.enum_class

        return self.render(schema_path, ordered, main_pod=main_pod,
                           overrides=[self.overrides_of(pod, own, partials) for pod in ordered
                                      if (own, pod["defs_name"]) in partials],
                           section_name=levels[0][0] if levels else None)

    def retype_ids(self, pod: dict[str, Any], own: str, *,
                   nested: bool, depth_of: dict[str, int], enum_names: set[str]) -> None:
        """Ids and the map keys built from them take the level's enum type; `name:` falls back to the YAML key."""
        for field in pod["fields"]:
            if field.yaml_name == "id" and nested and own in enum_names:
                field.populator, field.struct_name, field.cpp_type = "typed_id", field.cpp_type, f"xi::{snake_to_pascal(own)}"
                field.enum_name = own
            elif field.yaml_name == "name" and field.cpp_type == "std::string":
                field.populator = "name_key"

        # A level's own id leads the struct.
        if own in depth_of:
            declared_id = next((field for field in pod["fields"] if field.yaml_name == "id"), None)
            if declared_id:
                pod["fields"].remove(declared_id)
                pod["fields"].insert(0, declared_id)

        pod["cpp_type_width"] = max((len(field.cpp_type) for field in pod["fields"]), default=0)

    @staticmethod
    def overrides_of(pod: dict[str, Any], own: str, partials: set[tuple[str, str]]) -> dict[str, Any]:
        """The twin that says what a level literally wrote: every field optional, no defaults."""
        fields = []
        for field in pod["fields"]:
            if field.populator == "record_map":
                raise SystemExit(f"{own}.schema.json: '{pod['defs_name']}' is an override and holds a section; "
                                 f"there is no merge rule for a map of records")

            inner = field.cpp_type
            if field.populator in ("record", "mixin"):
                if (field.defs_source or own, field.defs_name) not in partials:
                    raise SystemExit(f"{own}.schema.json: '{pod['defs_name']}' is an override, so its "
                                     f"'{field.yaml_name}' record must be marked x-partial too")

                inner = SchemaWalker.overrides_name(inner)

            fields.append({"cpp_name": field.cpp_name, "yaml_name": field.yaml_name,
                           "populator": field.populator, "cpp_type": f"std::optional<{inner}>"})
        return {
            "struct_name": SchemaWalker.overrides_name(pod["struct_name"]),
            "data_struct_name": pod["struct_name"],
            "fields": fields,
            "cpp_type_width": max(len(entry["cpp_type"]) for entry in fields),
            "cpp_name_width": max(len(entry["cpp_name"]) for entry in fields),
        }

    def render(self, schema_path: Path, pods: list[dict[str, Any]], *, main_pod: dict[str, Any],
               **extra: Any) -> dict[str, Any]:
        name = self.source_of(schema_path)

        fields: list[Field] = []
        for pod in pods:
            fields.extend(pod["fields"])

        enum_includes = sorted({field.enum_name for field in fields if field.enum_name})
        # A shared record lives in its own header, not this one.
        shared_includes = sorted({field.defs_source for field in fields if field.defs_source})
        has_maps = any(field.populator == "record_map" for field in fields)

        ctx = dict(
            source=str(schema_path.relative_to(ROOT)).replace("\\", "/"),
            name=name,
            pods=pods,
            main_pod=main_pod,
            enum_includes=enum_includes,
            shared_includes=shared_includes,
            has_maps=has_maps,
            **extra,
        )
        return {
            "name": name,
            "pod": ENV.get_template("data_pod.h.j2").render(**ctx),
            "populator": ENV.get_template("data_populator.h.j2").render(**ctx),
        }
