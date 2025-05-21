import os
import requests
import zipfile
import platform
import tarfile
import json
import subprocess
import re
import argparse
from collections import defaultdict

parser = argparse.ArgumentParser(
    description="Run Lua Language Server and parse results."
)

parser.add_argument(
    "--blame",
    default=None,
    action="store_true",
    help="Annotate each error with the last editor of the line. Also produces a ranked table errors per committers.",
)

parser.add_argument(
    "--force",
    default=None,
    action="store_true",
    help="Force to run, even if there is an existing check.json result. The existing check.json result will be deleted.",
)

args = parser.parse_args()

if args.blame:
    print("Running git blame on each error line to find the last editor.")
else:
    print(
        "NOT running git blame on each error line to find the last editor (use --blame to enable)."
    )


# Before running the Lua language server we're going to scrape all our Lua bindings and build the spec files for them
# This assumes we're running from the root of the repository

lua_bindings_cpp_path = "./src/map/lua"
lua_specs_generation_folder = "./scripts/specs/generated"


def generate_spec_file(file):
    with open(file, "r") as f:
        lines = f.readlines()

        # Find the class name (SOL_USERTYPE("CZone", CLuaZone); -> CZone)
        class_name = None
        usertype_name = None
        registered_function_names = []
        function_definitions = []
        for line in lines:
            # Extract class name (SOL_USERTYPE("CZone", CLuaZone); -> CLuaZone)
            # Extract class name (SOL_USERTYPE("CZone", CLuaZone); -> CZone)
            if "SOL_USERTYPE" in line:
                parts = line.split('"')
                class_name = parts[2]
                usertype_name = parts[1]

            # Extract out function names (SOL_REGISTER("getSoloBattleMusic", CLuaZone::getSoloBattleMusic); -> getSoloBattleMusic)
            if "SOL_REGISTER" in line:
                function_name = line.split('"')[1]
                registered_function_names.append(function_name)

            # auto CLuaZone::getSoloBattleMusic()
            if "::" in line and "(" in line:
                function_name = line.split("::")[1].split("(")[0]
                function_definitions.append(function_name)

        if class_name:
            print(f"Generating spec file for {class_name} ({usertype_name}) in {file}")
            for function_name in registered_function_names:
                if function_name not in function_definitions:
                    print(
                        f"Warning: {function_name} is registered but not defined in {file}"
                    )
            for function_name in function_definitions:
                if function_name not in registered_function_names:
                    print(
                        f"Warning: {function_name} is defined but not registered in {file}"
                    )

# TODO:
# # Find all files ending in *.cpp in the lua bindings directory
# for root, dirs, files in os.walk(lua_bindings_cpp_path):
#     for file in files:
#         if file.endswith(".cpp"):
#             generate_spec_file(os.path.join(root, file))
#
# exit()

current_os = platform.system()
print(f"Current OS: {current_os}")

os_to_asset = {
    "Windows": "win32-x64.zip",
    "Linux": "linux-x64.tar.gz",
    "Darwin": "darwin-x64.tar.gz",
}

# URL of the GitHub API for the latest release
api_url = "https://api.github.com/repos/LuaLS/lua-language-server/releases/latest"

response = requests.get(api_url)

if response.status_code == 200:
    release_data = response.json()
    assets = release_data.get("assets", [])

    download_url = None
    for asset in assets:
        if os_to_asset.get(current_os) in asset["name"]:
            print(f"Asset found: {asset['name']}")
            download_url = asset["browser_download_url"]
            break

    if download_url:
        response = requests.get(download_url, stream=True)
        if response.status_code == 200:
            with open(
                f"./lua-language-server.{os_to_asset.get(current_os)}", "wb"
            ) as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)
            print("Language server downloaded successfully.")
        else:
            print("Failed to download the language server.")
else:
    print("Failed to access the release page.")

if os.path.exists(f"./lua-language-server.{os_to_asset.get(current_os)}"):
    if current_os == "Windows":
        with zipfile.ZipFile(
            f"./lua-language-server.{os_to_asset.get(current_os)}", "r"
        ) as zip_ref:
            zip_ref.extractall("./lua-language-server")
    else:
        with tarfile.open(
            f"./lua-language-server.{os_to_asset.get(current_os)}", "r:gz"
        ) as tar_ref:
            tar_ref.extractall("./lua-language-server")
    print("Language server extracted successfully.")
else:
    print("The downloaded file does not exist.")

lua_server_path = os.path.join("./lua-language-server", "bin", "lua-language-server")
config_path = "./.vscode/settings.json"
log_path = "."
scripts_path = "./scripts"
modules_path = "./modules/custom/lua"

lua_server_path = os.path.abspath(lua_server_path)
config_path = os.path.abspath(config_path)
log_path = os.path.abspath(log_path)
scripts_path = os.path.abspath(scripts_path)
modules_path = os.path.abspath(modules_path)

check_command = f'{lua_server_path} --loglevel="trace" --logpath="{log_path}" --check_format="json" --configpath="{config_path}" --checklevel="Information" --check="{scripts_path}"'

if args.force and os.path.exists("./check.json"):
    print("Force flag is enabled, removing existing check.json.")
    os.remove("./check.json")

if os.path.exists("./check.json"):
    print(
        "The check has already been run, parsing existing results (delete ./check.json to re-run)."
    )
else:
    print(f"Running LuaLS with config: {config_path}")
    print(check_command)
    os.system(check_command)


parsed_data = []
with open("./check.json", "r") as file:
    parsed_data = json.load(file)

if len(parsed_data) == 0:
    print("No errors found, removing check.json and exiting.")
    os.remove("./check.json")
    exit()

def get_committer(file, line):
    try:
        result = subprocess.run(
            ["git", "blame", "-L", f"{line + 1},{line + 1}", "--", file],
            capture_output=True,
            text=True,
            check=True,
        )
        output = result.stdout.strip()

        match = re.search(
            r"^\^?\w+\s+\(([^)]+?)\s+(\d{4}-\d{2}-\d{2})\s+\d{2}:\d{2}:\d{2}.*?\s+(\d+)\)",
            output,
            re.MULTILINE,
        )
        if match:
            name_email_date = match.group(1).strip()
            return name_email_date
    except subprocess.CalledProcessError as e:
        print(f"Error running git blame on {file}:{line + 1}")
        print(e)
        return "Unknown"
    return "Unknown"


error_list = []
for file, issues in parsed_data.items():
    for issue in issues:
        line = issue["range"]["start"]["line"]
        character = issue["range"]["start"]["character"]
        code = issue["code"]
        severity = issue["severity"]
        message = issue["message"]

        file = file.replace("file://", "")

        # Fix drive letter prefix
        if platform.system() == "Windows":
            if file[0] == "/" and file[2] == "%" and file[3] == "3" and file[4] == "A":
                print("Fixing drive letter prefix")
                file = file[5:]

        file = os.path.abspath(file)

        last_editor = "Unknown"
        if args.blame:
            last_editor = get_committer(file, line)

        error_list.append(
            {
                "file": file,
                "line": line,
                "character": character,
                "code": code,
                "message": message,
                "last_editor": last_editor,
                "severity": severity,
            }
        )

committer_errors = defaultdict(int)

for error in error_list:
    committer = error["last_editor"]
    committer_errors[committer] += 1

sorted_committers = sorted(committer_errors.items(), key=lambda x: x[1], reverse=True)

# Write ranked table and detailed error information to a file and print to console
print("\nWriting error information to lua_lang_errors.txt\n")
with open("lua_lang_errors.txt", "w") as error_file:
    if args.blame:
        # Write the ranked table of committers
        header = f"{'Committer':<50} | {'Errors':<6}\n"
        separator = "-" * 58 + "\n"
        print(header, end="")
        print(separator, end="")
        error_file.write(header)
        error_file.write(separator)
        for committer, count in sorted_committers:
            line = f"{committer:<50} | {count:<6}\n"
            print(line, end="")
            error_file.write(line)
    else:
        # Print total error count
        error_count = len(error_list)
        print(f"=== Total errors: {error_count} ===")
        error_file.write(f"=== Total errors: {error_count} ===")

    details_header = "\n=== Detailed error information ===\n"
    print(details_header, end="")
    error_file.write(details_header)

    severity_map = {
        1: "Error",
        2: "Warning",
        3: "Information",
        4: "Hint",
    }

    # Write detailed error information
    for error in error_list:
        error_details = (
            f"\nFile: {error['file']}:{error['line'] + 1}:{error['character'] + 1}\n"
            f"Last Editor: {error['last_editor']}\n"
            f"Code: {error['code']}\n"
            f"Severity: {severity_map[error['severity']]}\n"
            f"Message: {error['message']}\n"
        )

        # If git blame is not enabled, remove the line that starts with Last Editor (using regex)
        if not args.blame:
            error_details = re.sub(r"Last Editor:.*\n", "", error_details)

        print(error_details, end="")
        error_file.write(error_details)
