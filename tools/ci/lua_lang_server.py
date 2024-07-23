import os
import requests
import zipfile
import platform
import tarfile
import json
import subprocess
import re
from collections import defaultdict

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

lua_server_path = os.path.abspath(lua_server_path)
config_path = os.path.abspath(config_path)
log_path = os.path.abspath(log_path)
scripts_path = os.path.abspath(scripts_path)

check_command = f'{lua_server_path} --loglevel="trace" --logpath="{log_path}" --configpath="{config_path}" --checklevel="Information" --check="{scripts_path}"'

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

        # Remove "file://" prefix for git blame to work
        file_path = file.replace("file://", "")

        last_editor = get_committer(file_path, line)

        error_list.append(
            {
                "file": file_path,
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
print("\n\nWriting error information to lua_lang_errors.txt")
with open("lua_lang_errors.txt", "w") as error_file:
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

    # Add a newline between the table and the detailed errors
    details_header = "\nDetailed error information:\n\n"
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
            f"File: {error['file']}:{error['line'] + 1}:{error['character'] + 1}\n"
            f"Last Editor: {error['last_editor']}\n"
            f"Code: {error['code']}\n"
            f"Severity: {severity_map[error['severity']]}\n"
            f"Message: {error['message']}\n"
            "\n"
        )
        print(error_details, end="")
        error_file.write(error_details)
