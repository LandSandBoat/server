import glob
import sys

target = sys.argv[1]


def check(name):
    with open(name) as f:
        lines = f.readlines()

        counter = 0
        newline_counter = 0
        for data in lines:
            counter = counter + 1
            if not data.endswith("\n"):
                print(f"#### No newline at end of file, please add one.\n> {name}\n")

            if "\t" in data:
                print(
                    f"#### Found tab character(s) in file, please replace these with 4x spaces.\n> {name}:{counter}\n"
                )

            if data == "\n":
                newline_counter = newline_counter + 1
            else:
                newline_counter = 0

            if newline_counter > 1 or (counter == len(lines) and newline_counter == 1):
                print(
                    f"#### Found multiple newline characters next to each other, please replace these with single newlines.\n> {name}:{counter}\n"
                )


if target == ".":
    for filename in glob.iglob("scripts/**/*.lua", recursive=True):
        check(filename)
    for filename in glob.iglob("src/**/*.cpp", recursive=True):
        check(filename)
    for filename in glob.iglob("src/**/*.h", recursive=True):
        check(filename)
    for filename in glob.iglob("sql/**/*.sql", recursive=True):
        check(filename)
else:
    check(target)
