#! /bin/bash


read -ra PARAM_ARRAY <<< "$HUSKY_GIT_PARAMS"

set COMMIT_TYPE = "${PARAM_ARRAY[1]}"

if [ "$COMMIT_TYPE" == "template" ]; then
  echo "nothing?";
elif [ "$COMMIT_TYPE" == "message" ]; then
  echo "TODO: ask type and prefix message with it";
else
  echo $COMMIT_TYPE;
fi

