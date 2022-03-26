#!/bin/bash

# Requires pylint
# pip install pylint

target=${1:-src}

pylint --errors-only ${target}
