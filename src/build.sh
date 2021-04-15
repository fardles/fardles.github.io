#!/bin/bash

# Build htm from md (courtesty of @tehn)

### convert root md

echo ">> root .md to .html"

list=$(ls -r ./*.md)
for file in $list ; do
  file=${file:2}
  file=${file%.*}
  echo "$file"
  # convert md to html
  target=${file}.htm
  cat start.htm_ > ${target}
  cmark --unsafe ${file}.md >> ${target}
  cat end.htm_ >> ${target}
done

### build index, gen rss, md-html

echo ">> build log, rss"

list=$(ls -r ./*/*.md)

# log="log"

# cat start.htm_ > ${log}.html
# cat start_rss.xml_ > rss.xml

n=1

for file in $list ; do
  file=${file:2}
  subfile=${file%.*}
  folder=${subfile%\/*}
  name=${subfile#*\/}
  echo "$folder / $name"

  # convert md to html
  target=${file%.*}.htm
  cat start.htm_ > ${target}
  cmark --unsafe ${file} >> ${target}
  cat end.htm_ >> ${target}
done 

# Lint
clang-format -i main.c

# Cleanup
rm -f ./main
rm -rf ../site
mkdir ../site

# Linux(debug)
cc -std=c89 -DDEBUG -Wall -Wno-unknown-pragmas -Wpedantic -Wshadow -Wuninitialized -Wextra -Werror=implicit-int -Werror=incompatible-pointer-types -Werror=int-conversion -Wvla -g -Og -fsanitize=address -fsanitize=undefined main.c -o main

# Linux(fast)
# cc main.c -std=c89 -Os -DNDEBUG -g0 -s -Wall -Wno-unknown-pragmas -o main

# RPi
# tcc -Wall main.c -o main

# Plan9
# pcc main.c -o main

# Valgrind
# gcc -std=c89 -DDEBUG -Wall -Wpedantic -Wshadow -Wuninitialized -Wextra -Werror=implicit-int -Werror=incompatible-pointer-types -Werror=int-conversion -Wvla -g -Og main.c -o main
# valgrind ./main

# Build Size
# echo "$(du -b ./main | cut -f1) bytes written"

# Run
./main

# Cleanup
rm -f ./main