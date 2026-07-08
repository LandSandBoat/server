from typing import Any

import yaml

try:
    from yaml import CSafeLoader as FastLoader
except ImportError:
    from yaml import SafeLoader as FastLoader


class LinedDict(dict):
    __line__: int = 0


class LineLoader(yaml.SafeLoader):
    """SafeLoader variant that materializes mappings as LinedDict."""


def construct_lined_mapping(loader: yaml.Loader, node: yaml.MappingNode) -> LinedDict:
    m = LinedDict(loader.construct_mapping(node, deep=True))
    m.__line__ = node.start_mark.line + 1
    return m


LineLoader.add_constructor(yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, construct_lined_mapping)


def node_line(root: Any, path: list[str | int]) -> int:
    """Returns the deepest source line we reached; if the path drops out, the last LinedDict we passed through."""
    node = root
    last_lined = root
    for step in path:
        try:
            node = node[step]
        except (TypeError, KeyError, IndexError):
            break
        if hasattr(node, "__line__"):
            last_lined = node
    return getattr(last_lined, "__line__", 1)
