#!/usr/bin/env python
"""
Script which crawles USD sell rate from TBC bank's web page.
"""

import os
import sys
import urllib
import subprocess
from lxml.html import fromstring


__author__ = "Denis Iskandarov"
__copyright__ = "Copyright (c) 2015 Denis Iskandarov"
__license__ = "Apache-2.0"
__version__ = "0.1.0"
__maintainer__ = "Denis Iskandarov"
__email__ = "d.iskandarov [at] gmail.com"
__status__ = "Production"


def getval(url):
    doc = fromstring(url.read())
    elt = doc.xpath('//*[@id="ExchangeRates"]/div[1]/div[4]/div[2]/div[2]/text()')
    return float(elt[0].strip())


if __name__ == '__main__':
    try:
        url = urllib.urlopen('http://www.tbcbank.ge/web/en/web/guest/exchange-rates')
        val = getval(url)
        with open(os.devnull, 'w') as devnull:
            subprocess.check_call(["zabbix_sender", "-z", "127.0.0.1", "-s", "TBC_currency", "-k", "usdsell", "-o", str(val)], stdout=devnull)
    except subprocess.CalledProcessError:
        sys.exit(1)

    sys.exit()
