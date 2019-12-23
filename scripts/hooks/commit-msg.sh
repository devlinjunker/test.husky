#! /bin/bash

first=true;

# Parse message from commit message file (location passed with $HUSKY_GIT_PARAMS)
while IFS= read -r line;
do
  if [[ $line = \#* ]]; then
    continue;
  elif [[ -z $line ]]; then
    continue;
  else
    ## check that first line contains valid prefix
    if [ $first = true ]; then
      IFS=':' read -ra split <<< "$line";
      prefix=${split[0]};
      message=${split[1]};

      hasPrefix=true;
      # TODO: if $prefix has spaces hasPrefix=false; and request prefix/type from user

      # Has prefix to check
      if grep -q "$prefix" ".git-commit.types"; then
        continue;
      else
        values=`cat .git-commit.types | tr '\n' '|' | sed 's/.$//'`;
        echo "

        Error: Unexpected commit message prefix - $prefix
        Should be one of ($values)

        "
        exit 1;
      fi
      
      if [ $hasPrefix = false ]; then
        message=$line;
      fi 

      # TODO: Check number of words in message
      # TODO: spellcheck?
    fi
    first=false;
  fi
done < "$HUSKY_GIT_PARAMS"
