#!/usr/bin/env python3
"""
Extract caster action lock times from the retail client's animation DATs into data/animation_locks.yaml.
"""

import argparse
import importlib.util
import io
import os
import struct
from pathlib import Path
from types import SimpleNamespace

REPO = Path(__file__).resolve().parents[2]

# Race-indexed base tables from FFXiMain.dll .data, indexed by a race byte 0..8.
_WEAPON_SKILL_BASES = [0x81CB, 0x81CB, 0x84CB, 0x87CB, 0x8ACB, 0x8DCB, 0x8DCB, 0x90CB, 0x93CB]
_DANCER_BASES = [0xE2B9, 0xE2B9, 0xE439, 0xE5B9, 0xE739, 0xE8B9, 0xE8B9, 0xEA39, 0xEBB9]
_RUNE_FENCER_BASES = [0x157E3, 0x157E3, 0x15DE3, 0x163E3, 0x169E3, 0x16FE3, 0x16FE3, 0x175E3, 0x17BE3]


def race_blocks(bases, block_size):
    """
    One file id per race. 9 bases collapse to 7: index 0 copies HumeM, TaruM/TaruF share one.
    """
    blocks = list(dict.fromkeys(bases[1:]))
    return lambda animation_id: ([base + animation_id for base in blocks]
                                 if animation_id < block_size else [])


def mob_skill_ids(animation_id):
    for low, high, base in CONFIG.mob_skill_bands:
        if low <= animation_id < high:
            return [base + animation_id]

    return []


def item_ids(animation_id):
    # StartActionAnim swaps the base once the animation id reaches 100.
    return [(56485 if animation_id >= 100 else 4912) + animation_id]


# Script configuration
CONFIG = SimpleNamespace(
    # FFXI retail installation
    install=os.environ.get("FFXI_INSTALL_PATH", r"C:\Program Files (x86)\PlayOnline\SquareEnix\FINAL FANTASY XI"),
    # Final output
    yaml=REPO / "data" / "animation_locks.yaml",
    # ResolveMobSkillFileId. (first animation id, one past the last, offset)
    mob_skill_bands=[(0, 512, 3900),
                     (512, 1536, 49647),
                     (1536, 2048, 59193),
                     (2048, 4096, 84743)],
    # sub_kind is 12 bits, so this is every animation id an action packet can carry.
    animation_id_max=4096,

    # section -> the file ids an animation id resolves to, empty outside the section.
    sections={
        'weapon_skill': race_blocks(_WEAPON_SKILL_BASES, 256),
        'dancer': race_blocks(_DANCER_BASES, 384),
        'rune_fencer': race_blocks(_RUNE_FENCER_BASES, 1536),
        'magic': lambda anim: [2800 + anim],
        'ability': lambda anim: [4412 + anim],
        'item': item_ids,
        'mob_skill': mob_skill_ids,
        'pet': lambda anim: [49391 + anim],
    },

    # IdleLockCasterMagic and IdleLockCasterStatus. The other four lock movement, facing or the target.
    caster_lock_ops={0x59, 0x1F},

    # The client plays one alternative; reading the file counts them all, so the clock runs long after one.
    random_branch_ops={0x3D, 0x3E},

    # Certain animations have a 10000 tick placeholder and should be ignored.
    implausible_lock_ms=60000,

    yaml_header="""\
# yaml-language-server: $schema=schemas/animation_locks.schema.json
#
# Caster action lock in milliseconds, keyed by animation id.
# Trailing comment is the DAT FourCC and ROM path.
#
# Missing keys means no caster lock, do not fill one in.
#
# GENERATED from the retail client.
# Report issues before editing so they can be investigated.

""",
)


# ---------------------------------------------------------------------------
# DAT parsing
# ---------------------------------------------------------------------------

class Install:
    """
    VTABLE/FTABLE pairs. First folder of 1..9 with a nonzero VTABLE byte owns the file.
    """

    def __init__(self, base_path):
        self.base_path = Path(base_path)
        self.tables = {}
        for folder in range(1, 10):
            suffix = "" if folder == 1 else str(folder)
            directory = self.base_path if folder == 1 else self.base_path / f"ROM{folder}"
            vtable = directory / f"VTABLE{suffix}.DAT"
            ftable = directory / f"FTABLE{suffix}.DAT"
            if vtable.exists() and ftable.exists():
                self.tables[folder] = (vtable.read_bytes(), ftable.read_bytes())

        if not self.tables:
            raise SystemExit(f"no VTABLE/FTABLE under {base_path!r}; "
                             "pass --install or set FFXI_INSTALL_PATH")

        # One VTABLE byte per file id. Read rather than hardcoded, since a later client ships more.
        self.file_id_max = max(len(vtable) for vtable, _ in self.tables.values())

    def path_of(self, file_id):
        """
        (absolute path, ROM-relative path). Distinct file ids can share a path.
        """
        for vtable, ftable in self.tables.values():
            if file_id >= len(vtable) or vtable[file_id] == 0 or file_id * 2 + 2 > len(ftable):
                continue

            packed = struct.unpack_from("<H", ftable, file_id * 2)[0]
            if packed == 0:
                continue

            rom = "ROM" if vtable[file_id] == 1 else f"ROM{vtable[file_id]}"
            relative = f"{rom}/{packed >> 7}/{packed & 0x7F}.DAT"
            return self.base_path / relative, relative

        return None, None


def section_header(data, pos):
    """
    (type, byte size) from TypeSizeFlags at +0x04: type in bits 0-6, size in 16-byte units in bits 7-26.
    """
    flags = struct.unpack_from("<I", data, pos + 4)[0]
    return flags & 0x7F, ((flags >> 7) & 0xFFFFF) * 0x10


def find_schedulers(data):
    """
    Type 0x07 sections: FourCC, TypeSizeFlags, 24 zero bytes, four uint32 offsets.

    Walks the chain by size. A bad size resyncs at 0x10; the all-zero check keeps garbage out of that window.
    """
    found = []
    pos = 0
    while pos + 0x10 <= len(data):
        section_type, size = section_header(data, pos)
        if size < 0x10 or pos + size > len(data):
            pos += 0x10
            continue

        if section_type == 7 and size >= 0x30 and not any(data[pos + 8:pos + 0x20]):
            found.append({
                'name': data[pos:pos + 4].decode('ascii', errors='replace').rstrip('\x00'),
                'pos': pos,
                'size': size,
                'offsets': list(struct.unpack_from("<4I", data, pos + 0x20)),
            })

        pos += size

    return found


def parse_tags(data):
    """
    Variable-length tags into [[opcode, wait, howlong], ...].

    uint32 header: opcode in bits 0-7, size in bits 8-12 counted in dwords, flags in the rest.

    Tags of 8 bytes or more follow it with two uint16 tick counts: `wait` until the next tag fires, `howlong` for this tag's own effect.
    """
    tags = []
    pos = 0
    while pos + 4 <= len(data):
        header = struct.unpack_from("<I", data, pos)[0]
        opcode = header & 0xFF
        size = ((header >> 8) & 0x1F) * 4
        if size == 0 or pos + size > len(data):
            break

        wait, howlong = struct.unpack_from("<HH", data, pos + 4) if size >= 8 else (0, 0)
        tags.append([opcode, wait, howlong])
        pos += size
        if opcode == 0:  # "End"
            break

    return tags


def idle_tags(data, scheduler):
    """
    The scheduler's idle stream, `[offsets[1], offsets[2])`.
    """
    start = scheduler['pos']
    idle_offset, die_offset = scheduler['offsets'][1], scheduler['offsets'][2]
    end = min(start + scheduler['size'], len(data))

    idle_end = start + die_offset if 0 < die_offset and start + die_offset <= end else end - 0x10
    return parse_tags(data[start + idle_offset:idle_end]) if start + idle_offset < idle_end else []


# ---------------------------------------------------------------------------
# Tag stream -> one lock value
# ---------------------------------------------------------------------------

def caster_lock_ms(schedulers, source):
    """
    Furthest reach of the caster lock tags, max across the file's schedulers.
    """
    best = 0
    for scheduler in schedulers:
        elapsed = 0
        starts, ends, randoms = [], [], []
        for opcode, wait, howlong in scheduler['tags']:
            if opcode in CONFIG.caster_lock_ops:
                starts.append(elapsed)
                ends.append(elapsed + howlong)
            elif opcode in CONFIG.random_branch_ops:
                randoms.append(elapsed)

            elapsed += wait

        if not ends:
            continue

        if randoms and min(randoms) <= max(starts):
            raise ValueError(f"{source}: random branch at tick {min(randoms)} comes before the lock tag at tick {max(starts)}.")

        best = max(best, max(ends) - min(starts))

    return int(best / 60.0 * 1000) if best > 0 else None


def entry_of(records, file_id):
    """
    (lock ms, "<FourCC> <ROM path>") for a file, or None when it carries no lock.
    """
    record = records.get(file_id)
    if not record or record['header'] == 'dumm':  # 'dumm' is a placeholder, not an animation
        return None

    lock = caster_lock_ms(record.get('schedulers') or [], record['rom_path'])
    if lock is None:
        return None

    fourcc = ''.join(c for c in record['header'] if 32 < ord(c) < 127 and c != '#')
    return lock, f"{fourcc} {record['rom_path']}".strip()


def build_table(records, file_ids_of):
    """
    (animation id -> (lock ms, comment), cross-race conflicts, dropped).
    """
    table, conflicts, dropped = {}, 0, {}

    for animation_id in range(CONFIG.animation_id_max):
        found = [entry for entry in (entry_of(records, file_id)
                                     for file_id in file_ids_of(animation_id)) if entry]
        if not found:
            continue

        locks = [lock for lock, _ in found]
        lock = max(set(locks), key=locks.count)
        if lock >= CONFIG.implausible_lock_ms:
            dropped[animation_id] = lock
            continue

        conflicts += len(set(locks)) > 1
        table[animation_id] = (lock, found[0][1])

    return table, conflicts, dropped


def read_install(install):
    """
    file_id -> {header, rom_path, schedulers} for every DAT that has a scheduler.
    """
    records = {}
    missing = untimed = 0
    for file_id in range(install.file_id_max):
        path, rom_path = install.path_of(file_id)
        if path is None or not path.exists():
            missing += 1
            continue

        try:
            data = path.read_bytes()
        except OSError:
            missing += 1
            continue

        schedulers = find_schedulers(data)
        if not schedulers:
            untimed += 1
            continue

        records[file_id] = {
            'rom_path': rom_path,
            'header': data[:4].decode('ascii', errors='replace').rstrip('\x00'),
            'schedulers': [{'tags': idle_tags(data, scheduler)} for scheduler in schedulers],
        }

        if file_id % 10000 == 0:
            print(f"  {file_id}/{install.file_id_max}", flush=True)

    print(f"{len(records)} records, {missing} missing, {untimed} without a scheduler")
    return records


# ---------------------------------------------------------------------------
# export
# ---------------------------------------------------------------------------


def write_yaml(path, sections):
    from ruamel.yaml import YAML
    from ruamel.yaml.comments import CommentedMap

    locks = CommentedMap()
    for index, name in enumerate(CONFIG.sections):
        table = CommentedMap()
        for animation_id, (lock, comment) in sorted(sections.get(name, {}).items()):
            table[animation_id] = lock
            table.yaml_add_eol_comment(comment, animation_id)

        locks[name] = table
        if index:
            locks.yaml_set_comment_before_after_key(name, before="\n")

    document = CommentedMap()
    document['animation_locks'] = locks

    buffer = io.StringIO()
    yaml = YAML()
    yaml.indent(mapping=2, sequence=4, offset=2)
    yaml.width = 4096
    yaml.dump(document, buffer)

    # tools/yaml/format.py owns data YAML layout.
    spec = importlib.util.spec_from_file_location(
        "lsb_yaml_format", REPO / "tools" / "yaml" / "format.py")
    formatter = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(formatter)

    with open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(formatter.format_text(CONFIG.yaml_header + buffer.getvalue()))


def main():
    parser = argparse.ArgumentParser(description=__doc__.strip().split("\n")[0])
    parser.add_argument("-o", "--output", default=CONFIG.yaml)
    parser.add_argument("--install", default=CONFIG.install,
                        help="retail install directory [$FFXI_INSTALL_PATH]")
    args = parser.parse_args()

    install = Install(args.install)
    print(f"reading {install.base_path}")
    records = read_install(install)

    sections = {}
    for name, file_ids_of in CONFIG.sections.items():
        table, conflicts, dropped = build_table(records, file_ids_of)
        sections[name] = table

        note = f", {conflicts} cross-race conflicts" if conflicts else ""
        note += f", dropped {len(dropped)} implausible {dropped}" if dropped else ""
        print(f"  {name:<13} {len(table):>5} entries, highest animation {max(table, default=0)}{note}")

    write_yaml(args.output, sections)
    print(f"wrote {args.output}")


if __name__ == "__main__":
    main()
