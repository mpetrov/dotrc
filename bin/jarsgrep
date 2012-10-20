#!/bin/bash

pattern=$1
shift

for jar in $(find $* -type f -name "*.jar")
do
  match=`jar -tvf $jar | grep $pattern`
  if [ ! -z "$match" ]
  then
    echo "Found in: $jar"
    echo "$match"
  fi
done
