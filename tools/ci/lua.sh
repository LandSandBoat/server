#!/bin/bash
luarocks install luacheck --local
luarocks install lanes --local

~/.luarocks/bin/luacheck scripts -j 4
exit $?
