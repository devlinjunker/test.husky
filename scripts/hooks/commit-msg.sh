#! /bin/bash

values=`cat .git-commit.types | tr '\n' '|' | sed 's/.$//'`;
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
      # Seems like interacting with user is discouraged in githooks, so we'll just have to fail the commit and give message explaining how to fix
#      if [[ "$prefix" =~ \  ]]; then
#        hasprefix=false;
#        echo "commit message missing prefix, enter one now ($values): ";
#        read prefix;
#        while [ -z $(cat ".git-commit.types" | grep "$prefix") ]
#        do
#          read prefix;
#          if [[ $prefix = "q" ]]; then
#            exit 1;
#          fi
#          if [ -z $(cat ".git-commit.types" | grep "$prefix") ]; then
#            echo "prefix does not match, enter another ($values): ";
#          fi
#        done
#      fi

      # Has prefix to check
      if grep -q "$prefix" ".git-commit.types"; then
        continue;
      else
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
      if [[ $(echo $message | wc -w) -le 4 ]]; then
        echo "

        Error: Message should be 5+ words (but really you should add as much detail as possible)

        ";
        exit 1;
      fi
      # TODO: spellcheck?
    fi
    first=false;
  fi
done < "$HUSKY_GIT_PARAMS"


# TODO: Run tests unless prefix=wip (or message contains [skip-ci])?
