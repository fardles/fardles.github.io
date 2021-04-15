#!/bin/bash

d=$(date +%y%m%d)
f=$d

if test -f "$1"; then
  echo "photo: $1"
  if [ $2 ]
    then f="$f-$2"
  fi 
  echo "file: $f"
  low="../media/image/$f.jpg"
  convert $1 -auto-orient -resize 800 $low
  echo "![$d]($low)" > log/$f.md
  micro log/$f.md
  mv $1 log
fi