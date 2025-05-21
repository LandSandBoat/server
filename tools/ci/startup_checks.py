#!/usr/bin/python

import platform
import subprocess
import time
import signal
import threading
from queue import Queue, Empty

TEN_MINUTES_IN_SECONDS = 600
CHECK_INTERVAL_SECONDS = 2.5


processes = []


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


def main():
    print("Running exe startup checks...({})".format(platform.system()))

    # Start the processes
    processes = [
        subprocess.Popen(
            ["xi_connect", "--log", "connect-server.log"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            ["xi_search", "--log", "search-server.log"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            ["xi_map", "--ci", "--log", "map-server.log"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
        subprocess.Popen(
            ["xi_world", "--log", "world-server.log"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        ),
    ]

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
            exit(-1)

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
                    exit(-1)
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
                    exit(-1)

                # Check for "ready to work"
                if "ready to work" in lower_line:
                    print(f"==> {proc.args[0]} is ready!")
                    ready_status[proc] = True
                    kill(proc)

        # Check if all processes are marked ready
        if all(ready_status.values()):
            print("All processes reached 'ready to work'! Exiting successfully.")
            kill_all()
            exit(0)

        # Sleep until next poll
        time.sleep(CHECK_INTERVAL_SECONDS)


if __name__ == "__main__":
    main()
