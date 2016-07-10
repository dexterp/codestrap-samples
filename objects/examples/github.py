#!/usr/bin/env python
# vim: ft=python ts=4 sw=4 expandtab
#
# date: Wed Jul  6 06:46:15 2016

import os
import sys
import httplib
import json

def getinput(describe):
    sys.stderr.write(describe + ': ')
    line = sys.stdin.readline()
    line = line.rstrip()
    return line

def jsonfile():
    basefile = os.path.basename(__file__)
    return os.path.join(os.path.dirname(__file__),os.path.splitext(basefile)[0] + '.json')

def main(arguments):
    json_path = jsonfile()
    json_out = ''

    if not os.path.exists(json_path):
        resp = None
        while True:
            conn = httplib.HTTPSConnection('api.github.com')
            if not os.path.exists(json_path):
                username = getinput('What is your github username? ')

                conn.request(method='GET', url='https://api.github.com/users/' + username,headers={'User-Agent': 'Codestrap-Github-Metadata'})

                resp = conn.getresponse()

                if resp.status != 200:
                    sys.stderr.write('Invalid response code for https://api.github.com/users/' + username + '. Returned: ' + resp.status + '\n')
                    sys.stderr.write('Please reenter your username\n')
                else:
                    break

        output = json.loads(resp.read())
        json_out = json.dumps(output, indent = 4, separators = (',', ': '))

        with open(json_path, 'w') as fd:
            fd.write(json_out)

    with open(json_path, 'r') as fd:
        lines = fd.readlines()
        for line in lines:
            sys.stdout.write(line)

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
