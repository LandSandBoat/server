#############################
# announce.py
# Send a server message to all characters, in all zones, across all processes.
#
# Usage
# python3 announce.py "Here is a message from python!"
#
# Requirements
# pip3 install zmq pyzmq
#
#############################
import os
import sys
import subprocess

if len(sys.argv) < 2:
    print('Usage: announce.py "message..."', file=sys.stderr)
    sys.exit(2)

# Absolute path to this script's directory
HERE = os.path.dirname(os.path.abspath(__file__))

# Native announce binary should live alongside this script
EXE = os.path.join(HERE, "announce")

if not (os.path.isfile(EXE) and os.access(EXE, os.X_OK)):
    print("ERROR: announce binary not found.", file=sys.stderr)
    print("Expected at:", EXE, file=sys.stderr)
    print("Build with:", file=sys.stderr)
    print("  cmake -S . -B build && cmake --build build --target announce", file=sys.stderr)
    sys.exit(1)

msg = " ".join(sys.argv[1:])
subprocess.check_call([EXE, msg])
    main()
