# pip3 install requests

import sys
from datetime import date
from datetime import timedelta
import requests as reqs
import json
import urllib.parse

# At 12:00 on day-of-month 1 and 15.
# Cron: '0 12 1,15 * *'
def days_since_last_run():
    # Count back from today's date, until you encounter either the 1st or the 15th
    today = date.today()
    days = 1
    last_date_day = (today - timedelta(days = days)).day
    while last_date_day != 1 and last_date_day != 15:
        days = days + 1
        last_date_day = (today - timedelta(days = days)).day
    return days

length_days = 14
if len(sys.argv) >= 2:
    if "ci" in sys.argv[1]:
        length_days = days_since_last_run()
    else:
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
