import os
import subprocess

# If launching from somewhere that isnt <root>/tools/, figure out where dbtool.py is located, and the server root.
dbtool_dir_path = os.path.normpath(os.path.realpath(os.path.dirname(__file__)))
patch_dir = "../modules/catseyexi/cpp-patches"

def from_dbtool_path(path):
    return os.path.normpath(os.path.join(dbtool_dir_path, path))


def from_server_path(path):
    return os.path.normpath(os.path.join(server_dir_path, path))
    

def apply_patches():
    # Iterate through the patch files
    for filename in os.listdir(patch_dir):
        if filename.endswith(".patch"):
            patch_path = os.path.abspath(os.path.join(patch_dir, filename))
            try:
                # Use subprocess to run the 'git apply' command
                # subprocess.run(["git", "apply", "-R", patch_path], cwd="../")
                subprocess.run(["git", "apply", "--ignore-whitespace", "-v", patch_path], cwd="../", check=True)
                print(f"Applied patch: {filename}")
            except subprocess.CalledProcessError as e:
                print(f"Error applying patch {filename}: {e}")
            except Exception as e:
                print(f"Unknown error applying patch {filename}: {e}")

if __name__ == "__main__":
    apply_patches()