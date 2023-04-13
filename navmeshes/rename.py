from shutil import move
import sys

with open("../sql/zone_settings.sql", "r") as filestream:
    for line in filestream:
        content = line.split("(")[1]
        parts = content.split(",")
        zone_number = parts[0]
        zone_name = parts[4].replace('\'', '')
        zone_filename = zone_name + ".nav"

        try:
            move(zone_number + ".nav", zone_filename)
            print("Succeeded: ", zone_number, zone_filename)
        except:
            print("Failed: ", zone_number, zone_filename, sys.exc_info()[0])

