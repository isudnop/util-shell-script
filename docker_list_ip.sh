#!/bin/bash

DCONTAINERS=`docker ps --format='{{.Names}}'`
for d in ${DCONTAINERS[@]}; do
  echo ${d} - `docker inspect ${d}| grep "IPAddress\": \"[0-9].*\""|\
  sed 's/,//g' - | \cut -f2 -d ":" | sed 's/\"//g'` | sort -n
done;
