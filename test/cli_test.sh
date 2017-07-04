#!/bin/bash
# tests piped input to check stream processing
# this can be also acomplished with ruby
# read, write = IO.pipe
# read.sync = true
# and some Thread shenanigans
# but I am lazy, sorry
# I also think bash is good enough to test these things
# 
set -e
expected=`echo -e '$1,591.58\n$13,707.63'`
result=`echo -e \
  '$1,299.99, 3 people, food\n$12,456.95, 4 people, books\n' \
  | ./bin/pricer`
if [ "$result" == "$expected" ]
then exit 0
else
  echo -e "\e[31mExpected:\n ${expected}\n got:\n ${result}.\e[0m"
  exit 1
fi
