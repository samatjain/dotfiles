#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Send a magic packet to a list pre-programmed hostnames.

wakeonlan.sh is the old shell-based version; please use this program instead.

Requires the "wakeonlan" program is installed, i.e.

    sudo apt-get install -y wakeonlan

requirements.txt:

    sh
    termcolor
"""

import ipaddress
import sys
import typing
from pprint import pprint  # NOQA

from termcolor import colored
from sh import wakeonlan


class Host(typing.NamedTuple):
    """
    Groups information about hosts.

    Attributes:
        hostname: Non-FQDN hostname
        mac: MAC adddress, formatted 00:00:00:00:00:00
        ipv4: IPv4 address
        ipv6: IPv6 address

    """

    hostname: str
    mac: str = "00:00:00:00:00:00"
    ipv4: ipaddress.IPv4Address = ipaddress.IPv4Address('127.0.0.1')
    ipv6: ipaddress.IPv6Address = ipaddress.IPv6Address('::1')


HOSTS_LIST = [
    Host(hostname="apis",
         mac="ac:22:0b:cd:e1:69",
         ipv4=ipaddress.IPv4Address('192.168.1.156'),
    ),
    Host(hostname="tiny",
         mac="6c:3b:e5:0d:8d:81",
         ipv4=ipaddress.IPv4Address('192.168.1.187'),
    ),
    Host(hostname="nu",
         mac="70:85:c2:5a:14:19",
         ipv4=ipaddress.IPv4Address('192.168.1.240'),
    ),
    Host(hostname="kek",  # formerly ml110
         mac="08:f1:ea:16:36:fc",
         ipv4=ipaddress.IPv4Address('192.168.1.199')),
    Host(hostname="ba",  # formerly x3421
         mac="98:f2:b3:ee:4a:5c",
         ipv4=ipaddress.IPv4Address('192.168.1.120'),
    ),
    Host(hostname="x10sdv1",
         mac="0c:c4:7a:98:ae:e8",
         ipv4=ipaddress.IPv4Address('192.168.1.213'),
    ),
    Host(hostname="x10sdv2",
         mac="0c:c4:7a:87:b9:74",
         ipv4=ipaddress.IPv4Address('192.168.1.201'),
    ),
Host(hostname="synology",
         mac="00:11:32:af:32:8b",
         ipv4=ipaddress.IPv4Address('192.168.1.201'),
    ),
]
HOSTS_DICT = {h.hostname: h for h in HOSTS_LIST}


def main(hostname: str) -> None:
    """Wrapper around wakeonlan."""
    if hostname not in HOSTS_DICT:
        print(colored("error", "red") + ": ", end='', flush=True, file=sys.stderr)
        print("Unrecognized hostname.", file=sys.stderr)
        sys.exit(1)

    mac = HOSTS_DICT[hostname]
    wakeonlan(mac)
    print("Magic packet sent to", colored(hostname, 'green') + ".")


if __name__ == '__main__':
    if len(sys.argv) < 2 or sys.argv[1] in ("-h", "--help"):
        print(colored("usage", "yellow") + ": ", end='', flush=True, file=sys.stderr)
        print("{program_name} [HOSTNAME_TO_WAKE]".format(program_name=sys.argv[0]), file=sys.stderr)
        sys.exit(1)
    main(sys.argv[1])
