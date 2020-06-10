#!/usr/bin/python3

import sys
import requests

data_url="http://192.168.99.1:8000/geoip/pdt/"
while True:
    for line in sys.stdin:
        msg = line.strip()
        if not msg:
            break
        dict_data = {"data":  msg}
        requests.post(data_url, data=dict_data)

