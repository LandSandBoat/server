# py -m pip install requests
#
# Usage:
# .\tools\generate_changelog.py <days to generate, or "ci"> <repo owner name/repo name> <optional changelog title>
#
# NOTE: If you don't populate the optional changelog title, the repo owner name will be used
#
# Examples:
# .\tools\generate_changelog.py ci LandSandBoat/server
# => ## LandSandBoat Changelog
#
# .\tools\generate_changelog.py 7 LandSandBoat/server YourServerName
# => ## YourServerName Changelog

import glob
import os
import re
import sys
from datetime import date
from datetime import datetime
from datetime import timedelta
import requests as reqs
import json
import urllib.parse

# At 12:00 on day-of-month 1 and 15.
# Cron: '0 12 1,15 * *'
def get_last_date():
    file_path = os.path.realpath(__file__)
    parent_path = os.path.dirname(os.path.dirname(file_path))
    target_path = os.path.join(parent_path, "changelogs")
    files = glob.glob(os.path.join(target_path, "*.md"))
    if len(files) < 1:
        return None

    clean_files = filter(lambda x: "plain.md" not in os.path.basename(x), files)
    dates = list(map(lambda x: os.path.basename(x).replace(".md", ""), clean_files))
    dates.sort(key = lambda date: datetime.strptime(date, "%Y-%m-%d"))
    last_date = datetime.strptime(dates[len(dates) - 1], "%Y-%m-%d").date()
    start_date = last_date + timedelta(days=1)

    return start_date

def days_since_last_run():
    today = date.today()
    last_date = get_last_date() # Get the last day from the changelog files

    # If last_date is None, return 0 days
    if last_date is None:
        return 0

    # Calculate the difference in days between last_date and today
    days_difference = (today - last_date).days

    return days_difference

def get_good_description(body, fallback):
    start_str = "## Please enter a player-facing description"
    end_str = "## What does this pull request do? (Please be technical)"
    body_copy = body
    body_copy = re.sub("<!--.*-->", "", body_copy)

    start_index = body_copy.find(start_str)
    end_index = body_copy.find(end_str)

    if start_index == -1 or end_index == -1:
        return fallback

    start_index = start_index + len(start_str)
    description = body_copy[start_index:end_index]
    description = re.sub("\n", " ", description).strip()

    if len(description) > 5:
        return description

    return fallback

def is_real_name(str):
    parts = str.split(" ")

    parts_are_capitalized = True
    for part in parts:
        if part.capitalize() != part:
            parts_are_capitalized = False

    return len(parts) > 1 and parts_are_capitalized

def remove_real_names(authors):
    to_remove = set()
    for name in authors:
        if is_real_name(name):
            to_remove.add(name)

    for name in to_remove:
        try:
            authors.remove(name)
        except:
            pass

length_days = 14
last_run = get_last_date()
todys_date = date.today()

if last_run is not None:
    length_days = (todys_date - last_run).days

if len(sys.argv) < 3:
    print("Usage:\ngenerate_changelog.py <days to generate, or 'ci'> <repo owner name/repo name> <optional changelog title>")
    sys.exit(-1)
elif len(sys.argv) >= 2:
    if "ci" in sys.argv[1]:
        length_days = days_since_last_run()
    else:
        length_days = int(sys.argv[1])

repo_name = sys.argv[2]
user = repo_name.split("/")[0]
repo = repo_name.split("/")[1]

title = user
if len(sys.argv) >= 4:
    title = sys.argv[3]

print(f"Calculating changes for {length_days} days...")

today = date.today()
last_week = today - timedelta(days=length_days)

params = {
    "q": f"user:{user} repo:{repo} state:closed is:pr merged:>={str(last_week)}"
}
query_string = urllib.parse.urlencode(params)
request = f"https://api.github.com/search/issues?page=1&per_page=100&{query_string}"
response = reqs.get(request)
data = json.loads(response.text)

print(f"Writing to: changelog-{today}.md...")
with open(f"changelog-{today}.md", "w") as file:
    file.write(f"## {title} Changelog ({today})\n")
    for raw_entry in enumerate(data["items"]):
        entry = raw_entry[1]
        title = entry["title"]
        body = entry["body"]
        number = entry["number"]
        html_url = entry["html_url"]
        patch_url = entry["pull_request"]["patch_url"]
        username = entry["user"]["login"]

        # Extract out more author information
        authors = set()
        authors.add(username)
        patch = reqs.get(patch_url).text
        for line in patch.split("\n"):
            if line.startswith("From: "):
                authors.add(line.replace("From: ", "").split("<")[0].strip())

            if line.lower().startswith("co-authored-by: "):
                authors.add(line.split(":")[1].split("<")[0].strip())

        # Try and remove "real names"; even though these are already visible to the public, we
        # don't want to advertise them in our patch notes.
        remove_real_names(authors)

        # We want the submitting user to be first in the list, if relevant (and if the names match)
        authors_string = username
        if len(authors) > 1:
            # Since the authors_string starts with the submitting user, we can remove it from the set
            try:
                authors.remove(username)
            except:
                pass

            authors_string += ", "
            authors_string += ", ".join(authors)

        file.write(
            f"- {get_good_description(body, title).capitalize()} [[#{number}]({html_url}), [patch]({patch_url})] ({authors_string})\n"
        )
with open(f"changelog-{today}-plain.md", "w") as file:
    file.write(f"## AirSkyBoat Changelog ({today})\n")
    for raw_entry in enumerate(data["items"]):
        entry = raw_entry[1]
        title = entry["title"]
        body = entry["body"]
        number = entry["number"]
        html_url = entry["html_url"]
        patch_url = entry["pull_request"]["patch_url"]
        username = entry["user"]["login"]

        # Extract out more author information
        authors = set()
        authors.add(username)
        patch = reqs.get(patch_url).text
        for line in patch.split("\n"):
            if line.startswith("From: "):
                authors.add(line.replace("From: ", "").split("<")[0].strip())

            if line.lower().startswith("co-authored-by: "):
                authors.add(line.split(":")[1].split("<")[0].strip())

        # Try and remove "real names"; even though these are already visible to the public, we
        # don't want to advertise them in our patch notes.
        remove_real_names(authors)

        # We want the submitting user to be first in the list, if relevant (and if the names match)
        authors_string = username
        if len(authors) > 1:
            # Since the authors_string starts with the submitting user, we can remove it from the set
            try:
                authors.remove(username)
            except:
                pass

            authors_string += ", "
            authors_string += ", ".join(authors)

        file.write(
            f"- {get_good_description(body, title).capitalize()} [#{number}], ({authors_string})\n"
        )
