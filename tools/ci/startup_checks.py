#!/usr/bin/python

import io
import platform
import subprocess
import sys
import time

def main():
    arch = "x86"
    if len(sys.argv) > 1 and sys.argv[1] == "x64" and platform.system() == "Windows":
        arch = "x64"

    print("Running exe startup checks...({}/{})".format(platform.system(), arch))

    p0 = subprocess.Popen(["xi_connect","--log","connect-server.log"], stdout=subprocess.PIPE)
    p1 = subprocess.Popen(["xi_search","--log","search-server.log"], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["xi_map","--log","game-server.log"], stdout=subprocess.PIPE)

    print("Sleeping for 2 minutes...")

    time.sleep(120)

    p0.kill()
    p1.kill()
    p2.kill()

    print("Killing exes and checking logs...")

    has_seen_output = False
    error = False
    for proc in { p0, p1, p2 }:
        print(proc.args[0])
        for line in io.TextIOWrapper(proc.stdout, encoding="utf-8"):
            print(line.replace("\n", ""))
            has_seen_output = True
            if "error" in line or "warning" in line:
                print("^^^")
                error = True

    if not has_seen_output:
        print("ERROR: Did not get any output!")

    if error or not has_seen_output:
        exit(-1)

if __name__ == "__main__":
    main()
