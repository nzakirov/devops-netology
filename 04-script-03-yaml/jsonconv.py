#!/usr/bin/env python3

import sys
import os
import argparse
import json
import yaml
from json.decoder import JSONDecodeError

parser = argparse.ArgumentParser(description='Convert form json to yaml or yaml to  json.')
parser.add_argument("--file", required=True, type=str, help="Input file")

args = parser.parse_args()
input_file = args.file
file_ext = input_file.split('.')[-1]
file_name = '.'.join(input_file.split('.')[:-1])
if file_name == '':
    file_name = input_file

def exists(path):
    try:
        os.stat(path)
    except OSError:
        return False
    return True


def is_json(filename):
    with open(filename, "r") as f:
        try:
            content  = json.load(f)
            return [True, content]
        except JSONDecodeError as err:
            return [False, err]


def is_yaml(filename):
    with open(filename, "r") as f:
        try:
            content  = yaml.safe_load(f)
            return [True, content]
        except (yaml.parser.ParserError, yaml.scanner.ScannerError) as err:
            return [False, err]


if not exists(input_file):
    print('Error: File not found')
    sys.exit(1)

valid_json = is_json(input_file)
valid_yaml = is_yaml(input_file)

if valid_json[0]:
    with open(f"{file_name}.yaml", "w") as fo:
        yaml.dump(valid_json[1], fo)
elif valid_yaml[0]:
    with open(f"{file_name}.json", "w") as fo:
        json.dump(valid_yaml[1], fo)
else:
    print(valid_yaml[1])

