#! /bin/bash

while IFS= read -r line;
do
  if [[ $line = #* ]]; then
    continue;
  else
    echo "$line"
  fi
done < "$HUSKY_GIT_PARAMS"
