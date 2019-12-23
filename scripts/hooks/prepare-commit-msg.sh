#! /bin/bash


read -ra PARAM_ARRAY <<< "$HUSKY_GIT_PARAMS"

set COMMIT_TYPE = "${PARAM_ARRAY[1]}"

if [ "$COMMIT_TYPE" == "template" ]; then
  echo "Could ask type and save to prefix message with after added in editor";
elif [ "$COMMIT_TYPE" == "message" ]; then
  echo "TODO: ask type and save to prefix message with";
else
  echo $COMMIT_TYPE;
  # during `--amend` this will be empty
fi

