#!/bin/sh

FILE_PATH=$1

if [ "$FILE_PATH" = "" ]; then
  echo "Usage: $0 <file_path>" >&2
  exit 1
fi

while read -r line; do
  echo $line
done < $FILE_PATH
