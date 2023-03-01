#!/usr/bin/python

import io
import platform
import subprocess
import time
import signal

def main():
    print("Running exe startup checks...({})".format(platform.system()))

    p0 = subprocess.Popen(
        ["xi_connect", "--log", "connect-server.log"], stdout=subprocess.PIPE
    )
    p1 = subprocess.Popen(
        ["xi_search", "--log", "search-server.log"], stdout=subprocess.PIPE
    )
    p2 = subprocess.Popen(
        ["xi_map", "--log", "game-server.log", "--load_all"], stdout=subprocess.PIPE
    )
    p3 = subprocess.Popen(
        ["xi_world", "--log", "world-server.log"], stdout=subprocess.PIPE
    )


    print("Sleeping for 5 minutes...")

    time.sleep(300)

    print("Checking logs and killing exes...")

    has_seen_output = False
    error = False
    for proc in {p0, p1, p2, p3}:
        print(proc.args[0])
        proc.send_signal(signal.SIGTERM)
        for line in io.TextIOWrapper(proc.stdout, encoding="utf-8"):
            print(line.replace("\n", ""))
            has_seen_output = True
            if (
                "error" in line.lower()
                or "warning" in line.lower()
                or "crash" in line.lower()
            ):
                print("^^^")
                error = True

    if not has_seen_output:
        print("ERROR: Did not get any output!")

    if error or not has_seen_output:
        exit(-1)

    time.sleep(5)

if __name__ == "__main__":
    main()
