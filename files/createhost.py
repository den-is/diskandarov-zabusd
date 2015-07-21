#!/usr/bin/env python
"""
Script which creates zabbix host and adds zabbix trapper item on it.
"""

import requests
import json
import sys


__author__ = "Denis Iskandarov"
__copyright__ = "Copyright (c) 2015 Denis Iskandarov"
__license__ = "Apache-2.0"
__version__ = "0.1.0"
__maintainer__ = "Denis Iskandarov"
__email__ = "d.iskandarov [at] gmail.com"
__status__ = "Production"


URL = "http://127.0.0.1/api_jsonrpc.php"
APIKEY = None


def getapikey(user, password, url):
    data = {"jsonrpc": "2.0","method": "user.login","params": {"user": user,"password": password},"id": 1}
    r = requests.post(URL, json=data)
    result = json.loads(r.text)
    return str(result['result'])


def hostexists(hostname, url):
    host = {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
            "output": "extend",
            "filter": {
                "host": [hostname]
            }
        },
        "auth": APIKEY,
        "id": 1
        }
    r = requests.post(url, json=host)
    result = json.loads(r.text).get('result',{'error': 'no data'})
    if result:
        # hostid = result[0].get('hostid', -1)
        return True
    else:
        return False


def createhost(host, url):
    r = requests.post(url, json=host)
    result = json.loads(r.text)
    return result.get('result',{'error': 'no data'}).get('hostids', -1)[0]


def createitem(item, hostid, url):
    r = requests.post(url, json=item)
    result = json.loads(r.text)
    return result.get('result',0).get('itemids',0)[0]


if __name__ == '__main__':

    if not APIKEY:
        try:
            APIKEY = getapikey(user='Admin', password='zabbix', url=URL)
        except:
            print "Can't get API key."
            sys.exit(1)
    if not hostexists(hostname='TBC_currency', url=URL):

        newhost = {
            "jsonrpc": "2.0",
            "method": "host.create",
            "params": {
                "host": "TBC_currency",
                "interfaces": [{"type": 1, "main": 1, "useip": 1, "ip": "127.0.0.1", "dns": "", "port": "10050"}],
                "groups": [{"groupid": "2"}],
                "templates": [],
            },
            "auth": APIKEY,
            "id": 1
        }

        hostid = createhost(host=newhost, url=URL)

        newitem = {
            "jsonrpc": "2.0",
            "method": "item.create",
            "params": {
                "name": "USD sell rate",
                "key_": "usdsell",
                "units": "GEL",
                "hostid": hostid,
                "type": 2,
                "value_type": 0,
                "delay": 0,
                "status": 0,
            },
            "auth": APIKEY,
            "id": 1
        }

        createitem(item=newitem, hostid=hostid, url=URL)
    else:
        print "Host exists."
        sys.exit(1)

sys.exit()
