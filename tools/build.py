#!/usr/bin/env python3
"""Configure and build the project with a CMake preset. Defaults to RelWithDebInfo.

Runs, from the repo root:
    cmake --preset <configure preset>
    cmake --build --preset <preset> [--target <target>]

The presets use Ninja Multi-Config, so one build directory holds every
configuration and you choose it when you build. On Windows, if cl.exe is not
already on PATH, the script enters the Visual Studio developer environment
itself (via vswhere), so any shell works.

(Note: with presets the build directory comes from the preset, so it is
`cmake --build --preset default`, not `cmake --build build --preset default`.)

Presets:
    default   RelWithDebInfo, the one you want for everyday use
    debug     Debug, many times slower to run. Only for chasing a real problem
    release   Fully optimized, no debug info
    tracy     RelWithDebInfo with the Tracy profiler compiled in, into build-tracy/

Examples:
    python ./tools/build.py                 # configure + build everything, RelWithDebInfo
    ./tools/build.py --target xi_map         # just the map server
    ./tools/build.py --preset debug          # Debug instead
    ./tools/build.py --preset tracy          # profiling build
    ./tools/build.py --build-only            # skip the configure step
"""

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path


def developer_environment() -> tuple[str, dict] | None:
    """A `call VsDevCmd.bat` prefix and environment, or None when cl is already on PATH."""
    if sys.platform != "win32" or shutil.which("cl"):
        return None

    # msys shells drop variables with parentheses in the name, and VsDevCmd needs this one.
    program_files_x86 = os.environ.get("ProgramFiles(x86)", r"C:\Program Files (x86)")
    vswhere = (
        Path(program_files_x86)
        / "Microsoft Visual Studio"
        / "Installer"
        / "vswhere.exe"
    )
    if not vswhere.exists():
        return None

    def newest_install(*extra_args: str) -> str:
        result = subprocess.run(
            [
                str(vswhere),
                "-latest",
                *extra_args,
                "-products",
                "*",
                "-requires",
                "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
                "-property",
                "installationPath",
            ],
            capture_output=True,
            text=True,
        )
        return result.stdout.strip()

    install_dir = newest_install() or newest_install("-prerelease")
    if not install_dir:
        return None

    vsdevcmd = Path(install_dir) / "Common7" / "Tools" / "VsDevCmd.bat"
    if not vsdevcmd.exists():
        return None

    env = dict(os.environ)
    env["ProgramFiles(x86)"] = program_files_x86
    return f'call "{vsdevcmd}" -arch=x64 -host_arch=x64 -no_logo', env


DEVELOPER_ENVIRONMENT = developer_environment()


def run(cmd, cwd) -> int:
    print("+ " + " ".join(cmd))
    if DEVELOPER_ENVIRONMENT is None:
        return subprocess.run(cmd, cwd=cwd).returncode

    prefix, env = DEVELOPER_ENVIRONMENT
    command_line = f"{prefix} && {subprocess.list2cmdline(cmd)}"

    # Pass one string, not a list: a list goes through list2cmdline, which escapes the quotes
    # around the VsDevCmd path and leaves cmd.exe with a command it cannot find.
    return subprocess.run(command_line, cwd=cwd, env=env, shell=True).returncode


def configure_preset_for(preset, repo_root) -> str:
    """Map a build preset to the configure preset it belongs to.

    The configurations share one build directory, so `--preset debug` has to
    configure `default` and then build the Debug configuration out of it.
    """
    presets = json.loads((repo_root / "CMakePresets.json").read_text(encoding="utf-8"))
    for entry in presets.get("buildPresets", []):
        if entry.get("name") == preset:
            return entry.get("configurePreset", preset)
    return preset


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "-p",
        "--preset",
        default="default",
        help="CMake preset to configure and build. Default: default.",
    )
    parser.add_argument(
        "-t",
        "--target",
        default=None,
        help="Build a specific target instead of everything (e.g. xi_map).",
    )
    parser.add_argument(
        "--build-only",
        action="store_true",
        help="Skip the configure step and only build.",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent

    if not args.build_only:
        rc = run(
            ["cmake", "--preset", configure_preset_for(args.preset, repo_root)],
            repo_root,
        )
        if rc != 0:
            return rc

    build_cmd = ["cmake", "--build", "--preset", args.preset]
    if args.target:
        build_cmd += ["--target", args.target]
    return run(build_cmd, repo_root)


if __name__ == "__main__":
    sys.exit(main())
