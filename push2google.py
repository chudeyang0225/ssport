import time
import datetime
import random
import requests
import csv, os

URL = 'SCRIPT.URL.FROM.GOOGLE.SHEETS'

def gdoc_post(data):
    csv = "\n".join(
        ",".join(str(it) for it in line) for line in data
    )

    requests.post(URL + "?sheet=Raw", csv)

if __name__ == '__main__':
    with open('/portlog.csv') as r:
        data = csv.reader(r)
        gdoc_post(data)
    os.system('rm /portlog.csv')

