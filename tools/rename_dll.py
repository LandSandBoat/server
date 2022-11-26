# https://github.com/cmberryau/rename_dll/blob/master/rename_dll.py
# Make sure you're running this script in a developer command prompt or dumpbin and lib will not be found

import argparse
import subprocess
import re
from shutil import copyfile

parser = argparse.ArgumentParser(
    description="Renames a dll file, generates new def and lib files"
)
parser.add_argument("inputdll", help="input dll")
parser.add_argument("outputdll", help="output dll")
parser.add_argument("arch", help="architecture (x86 or x64, defaults to x64)")
args = parser.parse_args()

# dump the dll exports using dumpbin
process = subprocess.Popen(
    ["dumpbin", "/EXPORTS", args.inputdll], stdout=subprocess.PIPE
)
out, err = process.communicate()

# get all the function definitions
lines = out.splitlines(keepends=False)
pattern = r"^\s*(\d+)\s+[A-Z0-9]+\s+[A-Z0-9]{8}\s+([^ ]+)"

library_output = "EXPORTS \n"

for line in lines:
    matches = re.search(pattern, line.decode("ascii"))

    if matches is not None:
        # ordinal = matches.group(1)
        function_name = matches.group(2)
        library_output = library_output + function_name + "\n"

# write the def file
deffile_name = args.outputdll[:-4] + ".def"
with open(deffile_name, "w") as f:
    f.write(library_output)

machine = "/MACHINE:X64"
if args.arch == "x86":
    machine = "/MACHINE:X86"

process = subprocess.Popen(
    ["lib", machine, "/DEF:" + deffile_name],
)
process.communicate()

# copy the dll over
copyfile(args.inputdll, args.outputdll)
