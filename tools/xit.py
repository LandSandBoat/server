# xit: XI (Server Management) Tool
# Pronounced "zit"
# All-in-one management tool for LSB servers
# Usage: ./xit.py <check, start, stop, help>
# or
# Double-click xit.py

#

# TODO:
# From HXI:
# Here's the basic things that we're scripting
# - Log Archival & Cleanup (eventually log ingest for 3rd party services)
# - Crash dump Archival & Cleanup
# - DB Updates / Migrations
# - Build cache clear / remake
# - Backups (incremental)
# - Backups (full)
# - Update (pull from github branch, handle all from above)
# - Start/Stop of Daemons
#
# - Status Screen (process up/down, uptime, health, etc.)
# - Read zone_settings and launch/multi-launch/setup logs automatically etc.
# - Logging/Audit settings


# Internal Deps
import os
import subprocess
import sys
import re
import time
import fileinput
import shutil
import importlib
import pathlib
import atexit
import locale
import ctypes


def soft_exit():
    # If double clicked on Windows: pause with an input so the user can read the error...
    # TODO: This isn't bulletproof
    if os.name == "nt" and "PROMPT" not in os.environ:
        input("Press ENTER to continue...\n(It is safe to close the window)")

atexit.register(soft_exit)

# Ensure python version
if sys.version_info < (3, 7):
    print(f"Python version too low, please update to 3.7 or higher (found: {sys.version_info.major}.{sys.version_info.minor})")
    sys.exit(-1)


# External Deps (requirements.txt)
try:
    import mariadb
    from mariadb.constants import *
    from git import Repo
    import yaml
    import colorama
except Exception as e:
    print("ERROR: Exception occured while importing external dependencies:")
    print(e)
    print(
        "Ensure you've run/re-run the command you use to install python dependencies (example: pip install --upgrade -r requirements.txt)"
    )


# - git should installed and available
try:
    subprocess.call(["git"], stdout=subprocess.PIPE)
except Exception:
    print(
        "ERROR: Make sure git is installed and available on your system's PATH environment variable."
    )


# If launching from somewhere that isnt <root>/tools/, figure out where dbtool.py is located, and the server root.
xit_dir_path    = os.path.normpath(os.path.realpath(os.path.dirname(__file__)))
server_dir_path = os.path.normpath(os.path.realpath(os.path.dirname(xit_dir_path)))


def from_xit_path(path):
    return os.path.normpath(os.path.join(xit_dir_path, path))


def from_server_path(path):
    return os.path.normpath(os.path.join(server_dir_path, path))


# TODO: Make this enable "DETACHED MODE", where there's a big warning on the main menu
#     : explaining that a lot of features will be disabled.
# - Repo should be checked out as a git repo, not as plain files
if (
    not subprocess.call(
        ["git", "-C", server_dir_path, "status"],
        stderr=subprocess.STDOUT,
        stdout=open(os.devnull, "w"),
    )
    == 0
):
    print(
        "ERROR: The project must be checked out as a git repo (using git clone, or similar)."
    )


GREEN = colorama.Fore.GREEN
RED = colorama.Fore.RED
RESET = colorama.Style.RESET_ALL
NOOP = lambda *args, **kwargs: None


def print_red(str):
    print(colorama.Fore.RED + str)


def print_green(str):
    print(colorama.Fore.GREEN + str)


def bad_selection():
    print_red("Invalid selection.")
    time.sleep(0.5)


def get_os_language():
    if os.name == "nt":
        windll = ctypes.windll.kernel32
        return locale.windows_locale[windll.GetUserDefaultUILanguage()]
    else:
        return locale.getdefaultlocale()[0]


# fmt: off
def present_menu(title, contents):
    # Determine width of entire menu, including multiline titles
    # and menu items
    length = 0
    title_parts = title.split("\n")

    for part in title_parts:
        length = max(len(part), length)

    for value in contents.values():
        length = max(len(value[0]), length)

    # Add some more padding to account for the manual styling of
    # menu options and spacings
    option_pad = 3
    length = length + option_pad

    LEFT  = "| "
    RIGHT = " |"

    # Present title
    print(
        GREEN + "o" + RED + "-" + "-" * length + "-" + GREEN + "o"
    )
    for part in title_parts:
        print(
            RED + LEFT + RESET + part.center(length) + RED + RIGHT
        )
    print(
        GREEN + "o" + RED + "-" + "-" * length + "-" + GREEN + "o"
    )

    # Menu options
    for key, value in contents.items():
        description = value[0]
        print(
            RED + LEFT + GREEN + key + RESET + ". " + description + " " * (length - len(description) - option_pad) + RED + RIGHT
        )

    # Footer
    print(colorama.Fore.GREEN + "o" + colorama.Fore.RED + "-" + "-" * length + "-" + colorama.Fore.GREEN + "o\n")

    # Handle inputs
    selection = input("> ").lower()
    print(colorama.ansi.clear_screen())
    contents.get(selection, ["", bad_selection])[1]()
# fmt: on


def main():
    # Parse args

    # Gather credentials and settings

    # Connect to db

    # Locate exes

    try:
        # Main menu loop
        print(colorama.ansi.clear_screen())
        while True:
            colorama.init(autoreset=True)
            title = (
                "xit: XI (Server Management) Tool\nGit Commit: 00000000\nDatabase: xidb (Last Backup: Never!)\nConfiguration: 7 map processes\nService: Not installed\nServer: Offline (ip: XXX.XXX.XXX.XXX)"
            )

            options = {
                "d": ["Diagnostics (generate 'diag.txt')", NOOP],
                "s": ["Setup", NOOP],
                "m": ["Maintenance (inc. backups)", NOOP],
                "g": ["GM Tools", NOOP],
                "c": ["CI Menu", NOOP],
                "h": ["Help", NOOP],
                "q": ["Quit", sys.exit],
            }

            present_menu(title, options)
    except KeyboardInterrupt:
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)


if __name__ == "__main__":
    main()
