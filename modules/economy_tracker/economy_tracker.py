# economy_tracker.py
# Produce a nice gil-over-time graph
#
# Usage: python economy_tracker.py

# Dependencies:
# pip install mysql-connector-python
# pip install matplotlib

import mysql.connector
import matplotlib.pyplot as plt

# TODO: Look up db creds from config files
db = mysql.connector.connect(host="localhost", user="root", password="root", database="xidb")
cursor = db.cursor()

# globals
total_gil = []
timestamps = []
amounts = []
transactions = []
richest = []

def prepare_data():
    # ====================================================
    cursor.execute("SELECT SUM(quantity) from char_inventory where itemid = 65535 LIMIT 1;")
    result = cursor.fetchone()
    total_gil.append(result)

    # ====================================================
    cursor.execute("SELECT `timestamp`, total_gil FROM xidb.economy_total_gil ORDER BY `timestamp` ASC;")
    result = cursor.fetchall()
    for entry in result:
        timestamps.append(entry[0])
        amounts.append(entry[1] / 1000000) # Divide into mils, for clarity

    # ====================================================
    cursor.execute("SELECT `charname`, `change` FROM chars INNER JOIN economy_large_transactions ON chars.charid = economy_large_transactions.charid ORDER BY 'ASC' LIMIT 10;")
    result = cursor.fetchall()
    for entry in result:
        transactions.append([entry[0], str(entry[1])])

    # ====================================================
    cursor.execute("SELECT `charname`, `quantity` FROM chars INNER JOIN char_inventory ON chars.charid = char_inventory.charid WHERE itemId = 65535 ORDER BY 'ASC' LIMIT 10;")
    result = cursor.fetchall()
    for entry in result:
        richest.append([entry[0], str(entry[1])])

def prepare_plots():
    fig = plt.figure("Economy Tracker")

    # ====================================================
    ax = plt.subplot(2, 2, 1)
    ax.set_title('Total Gil')
    fig.patch.set_visible(False)
    ax.axis('off')
    ax.axis('tight')
    ax.table(
        cellText = total_gil,
        cellLoc ='center',
        loc ='upper left')

    # ====================================================
    ax = plt.subplot(2, 2, 2)
    ax.set_title('Largest Transactions')
    fig.patch.set_visible(False)
    ax.axis('off')
    ax.axis('tight')
    ax.table(
        cellText = transactions,
        colLabels = ("Name", "Transaction Size"),
        colColours =["lightgrey"] * 10,
        cellLoc ='center',
        loc ='upper left')

    # ====================================================
    plt.subplot(2, 2, 3)
    plt.title('Total gil over time')
    plt.plot(timestamps, amounts)
    plt.xticks(rotation=45)
    plt.ylabel('Total gil (millions)')

    # ====================================================
    ax = plt.subplot(2, 2, 4)
    ax.set_title('Richest Characters')
    fig.patch.set_visible(False)
    ax.axis('off')
    ax.axis('tight')
    ax.table(
        cellText = richest,
        colLabels = ("Name", "Total Gil"),
        colColours =["lightgrey"] * 10,
        cellLoc ='center',
        loc ='upper left')

def present():
    plt.tight_layout()
    plt.show()

def main():
    prepare_data()
    prepare_plots()
    present()

if __name__ == "__main__":
    main()
