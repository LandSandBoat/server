import os
import requests
import zipfile
import platform
import tarfile
import json

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

parsed_data = None
with open("./check.json", "r") as file:
    parsed_data = json.load(file)

for file, issues in parsed_data.items():
    for issue in issues:
        line = issue["range"]["start"]["line"]
        character = issue["range"]["start"]["character"]
        code = issue["code"]
        message = issue["message"]

        print(f"{file}:{line}:{character} | {code} | {message}")
