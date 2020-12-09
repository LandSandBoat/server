#!/bin/bash
cd sql
for f in *.sql
  do
     echo -n "Importing $f into the database..."
     mysql tpzdb_test -u root < $f && echo "Success"
     CODE=$?
     if [ $CODE -ne 0 ]; then exit $CODE; fi
  done
cd ..
