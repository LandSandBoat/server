# pip3 install requests

import sys
from datetime import date
from datetime import timedelta
import requests as reqs
import json
import urllib.parse

length_days = 14
if len(sys.argv) >= 2:
    length_days = int(sys.argv[1])

print(f"Calculating changes for {length_days} days...")

today = date.today()
last_week = today - timedelta(days = length_days)

params = {"q" : f"user:LandSandBoat repo:server state:closed is:pr merged:>={str(last_week)}"}
query_string = urllib.parse.urlencode(params)
request = f"https://api.github.com/search/issues?page=1&per_page=100&{query_string}"
response = reqs.get(request)
data = json.loads(response.text)

print(f"Writing to: changelog-{today}.md...")
with open(f'changelog-{today}.md', 'w') as file:
    file.write(f"## LandSandBoat Changelog ({today})\n")
    for raw_entry in enumerate(data["items"]):
        entry = raw_entry[1]
        title = entry['title']
        number = entry['number']
        html_url = entry['html_url']
        patch_url = entry["pull_request"]['patch_url']
        username = entry['user']['login']
        file.write(f"- {title.capitalize()} [[#{number}]({html_url}), [patch]({patch_url})] ({username})\n")
