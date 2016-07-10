#!/usr/bin/env python
# vim: ft=python ts=4 sw=4 expandtab
#
# date: Fri Jul  8 20:34:23 2016

import os
import sys
import json
import re

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

    correct = False
    if not os.path.exists(json_path):
        while True:
            sys.stderr.write("Initial setup %s \n" % json_path)
            output = { 'full_name': getinput('Full Name'), 'username': getinput('Username'), 'email': getinput('Email Address') }
            json_out = json.dumps(output, indent = 4, separators = (',', ': '))

            sys.stderr.write(json_out + "\n")

            check = getinput("Does this look correct? (Yes/No)")

            if re.match('^(?:[Yy][Ee][Ss]|[Yy])',check):
                correct = True
                break

    if correct:
        with open(json_path,'w') as fd:
            fd.write(json_out)

    if os.path.exists(json_path):
        with open(json_path, 'r') as fd:
            lines = fd.readlines()
            for line in lines:
                sys.stdout.write(line)

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
