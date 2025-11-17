#!/usr/bin/python

import importlib
import mariadb
import os
import platform
import signal
import subprocess
import sys
import time
import threading

from mariadb.constants import *
from queue import Queue, Empty

TEN_MINUTES_IN_SECONDS = 600
CHECK_INTERVAL_SECONDS = 2.5

processes = []
db = None
cur = None

database = os.getenv("XI_NETWORK_SQL_DATABASE")
host = os.getenv("XI_NETWORK_SQL_HOST")
port = int(os.getenv("XI_NETWORK_SQL_PORT"))
login = os.getenv("XI_NETWORK_SQL_LOGIN")
password = os.getenv("XI_NETWORK_SQL_PASSWORD")


server_dir_path = os.path.normpath(
    os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)


def from_server_path(path):
    return os.path.normpath(os.path.join(server_dir_path, path))


def connect():
    global db, cur
    try:
        db = mariadb.connect(
            host=host, user=login, passwd=password, db=database, port=port
        )
        cur = db.cursor()
    except mariadb.Error as err:
        if err.errno == mariadb.constants.ERR.ER_ACCESS_DENIED_ERROR:
            print(
                "Incorrect mysql_login or mysql_password, update settings/network.lua."
            )
            close(-1)
        elif err.errno == mariadb.constants.ERR.ER_BAD_DB_ERROR:
            print("Database " + database + " does not exist.")
            close(-1)
        else:
            print(str(err))
            close(-1)


def db_query(query):
    result = subprocess.run(
        [
            f"mysql",
            f"-h{host}",
            f"-P{str(port)}",
            f"-u{login}",
            f"-p{password}",
            database,
            f"-e {query}",
        ],
        capture_output=True,
        text=True,
    )
    return result


def setup_test_character():
    print("Setting up test character...")
    PASSWORD_HASH = "$2a$12$piFoDKvu80KK68xLgQFpt.ZCqVPTjPmhSUfA31.Yw9n404dTsrR6q"
    try:
        # Create an account
        cur.execute(
            f"REPLACE INTO accounts (id, login, password, timecreate, timelastmodify, status, priv) \
                VALUES(1000, 'admin1', '{PASSWORD_HASH}', NOW(), NOW(), 1, 1);"
        )
        # Create a character
        cur.execute(
            "REPLACE INTO chars (charid, accid, charname, pos_zone, nation, gmlevel) \
                VALUES(1, 1000, 'Test', 0, 0, 5);"
        )
        # Set char_look (default is 0 and trips up scripting)
        cur.execute(
            "REPLACE INTO char_look (charid, face, race, size, head, body, hands, legs, feet, main, sub, ranged) \
                VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);"
        )
        # Populate more char tables with defaults
        cur.execute("REPLACE INTO char_stats (charid, mjob) VALUES(1, 1);")

        # Place near some Robber Crabs in Kuftal Tunnel
        cur.execute(
            "UPDATE chars SET \
            pos_zone = 174, \
            pos_prevzone = 174, \
            pos_x = 55, \
            pos_y = -9, \
            pos_z = -140 \
        WHERE charid = 1;"
        )

        # Set GodMode
        cur.execute(
            "INSERT INTO char_vars(charid, varname, value) VALUES(1, 'GodMode', 1);"
        )

        db.commit()

        return 0
    except:
        print("An error occurred.")
        return -1


def kill(process):
    """Send SIGTERM to a running process."""
    if process.poll() is None:  # still running
        process.send_signal(signal.SIGTERM)


def kill_all():
    """Send SIGTERM to all running processes."""
    for proc in processes:
        kill(proc)


def reader_thread(proc, output_queue):
    """
    Reads lines from proc.stdout and puts them into the output_queue
    along with a reference to the proc.

    When the process ends (stdout is closed), push a (proc, None)
    to indicate it's done.
    """
    with proc.stdout:
        for line in proc.stdout:
            # 'line' already in string form since we use text=True
            output_queue.put((proc, line))
    # Signal that this proc has ended
    output_queue.put((proc, None))


def close(code):
    if db:
        print("Closing connection...")
        cur.close()
        db.close()
    sys.exit(code)


def main():
    print("Running exe startup checks...({})".format(platform.system()))

    # Start the processes
    processes = [
        subprocess.Popen(
            [from_server_path("xi_connect")],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            [from_server_path("xi_search")],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            [
                from_server_path("xi_map"),
                # "--ci",
                "--log",
                "log/map-server-(1).log",
                "--ip",
                "127.0.0.1",
                "--port",
                "54230",
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            [from_server_path("xi_world")],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
    ]

    if len(sys.argv) > 1:
        if "multi" == str(sys.argv[1]):
            connect()
            if cur:
                cur.execute(
                    "UPDATE xidb.zone_settings SET zoneport = 54231 WHERE zoneid % 2 = 1;"
                )
                db.commit()
                processes.insert(
                    3,
                    subprocess.Popen(
                        [
                            from_server_path("xi_map"),
                            # "--ci",
                            "--log",
                            "log/map-server-(2).log",
                            "--ip",
                            "127.0.0.1",
                            "--port",
                            "54231",
                        ],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        text=True,
                    ),
                )

    # Keep track of which processes have reported "ready to work"
    ready_status = {proc: False for proc in processes}

    # Sleep for a moment to give the processes time to start up
    time.sleep(1)

    # Create a queue to receive stdout lines from all processes
    output_queue = Queue()

    # Start a reading thread for each process
    threads = []
    for proc in processes:
        t = threading.Thread(
            target=reader_thread, args=(proc, output_queue), daemon=True
        )
        t.start()
        threads.append(t)

    print(
        f"Polling process output every {CHECK_INTERVAL_SECONDS}s for up to {TEN_MINUTES_IN_SECONDS}s..."
    )

    start_time = time.time()
    error_strs = ["error", "warning", "crash", "critical"]

    while True:
        # If we've hit the timeout (10 minutes), fail
        if time.time() - start_time > TEN_MINUTES_IN_SECONDS:
            print("Timed out waiting for all processes to become ready.")
            kill_all()
            close(-1)

        # Poll the queue for new lines
        # We'll keep pulling until it's empty (non-blocking)
        while True:
            try:
                proc, line = output_queue.get_nowait()
            except Empty:
                break  # No more lines at the moment

            # If line is None, that means this proc ended
            if line is None:
                # If the process ended but wasn't marked ready => error
                if not ready_status[proc]:
                    pid = proc.pid
                    return_code = proc.returncode
                    print(
                        f"ERROR: {proc.args[0]} (PID: {pid}) exited before it was 'ready to work' with code {return_code}."
                    )
                    kill_all()
                    close(-1)
            else:
                # We have an actual line of output
                line_str = line.strip()
                print(f"[{proc.args[0]}] {line_str}")

                # Check for error or warning text
                lower_line = line_str.lower()
                if any(x in lower_line for x in error_strs):
                    print("^^^ Found error or warning in output.")
                    kill_all()
                    print("Killing all processes and exiting with error.")
                    close(-1)

                # Check for "ready to work"
                if "ready to work" in lower_line:
                    print(f"==> {proc.args[0]} is ready!")
                    ready_status[proc] = True

        # Check if all processes are marked ready
        if all(ready_status.values()):
            print("All processes reached 'ready to work'!")
            if platform.system() == "Linux":
                from tools.headlessxi.hxiclient import HXIClient

                if not cur:
                    connect()
                setup_test_character()
                hxi_client = HXIClient("admin1", "admin1", "localhost")

                print("Logging in test character...")
                hxi_client.login()

                print("Sleeping 60s")
                time.sleep(60)

                print("Logging out test character...")
                hxi_client.logout()

            print("Shutting down processes...")
            time.sleep(0.5)
            kill_all()
            close(0)

        # Sleep until next poll
        time.sleep(CHECK_INTERVAL_SECONDS)


if __name__ == "__main__":
    main()
