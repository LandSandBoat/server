#!/bin/bash

# Requires the following packages:
# cppcheck

target=${1:-src}

# --enable=performance
# Enable additional checks. The available ids are:
# all - Enable all checks
# style - Check coding style
# performance - Enable performance messages
# portability - Enable portability messages
# information - Enable information messages
# unusedFunction - Check for unused functions
# missingInclude - Warn if there are missing includes. For detailed information use --check-config
# Several ids can be given if you separate them with commas, e.g. --enable=style,unusedFunction. See also --std

# --suppress=passedByValue:src/map/packet_system.cpp
# The compiler produces the same assembly for passByValue, std::move and
# passByConstRef here, so we can silence this warning.
# https://quick-bench.com/q/13EX97WSfj9-rY_98opaAwgDOQc

cppcheck -v -j 4 --force --quiet --inconclusive --std=c++17 \
--enable=information,performance,portability  --inline-suppr \
--suppress=passedByValue:src/map/packet_system.cpp \
-DSA_INTERRUPT -DZMQ_DEPRECATED -DZMQ_EVENT_MONITOR_STOPPED -DTRACY_ENABLE \
${target}
