#! /bin/bash


read -ra PARAM_ARRAY <<< "$HUSKY_GIT_PARAMS"

if [ "${PARAM_ARRAY[1]}" == "template" ]; then
  echo "nothing?";
elif [ "${PARAM_ARRAY[1]}" == "message" ]; then
  echo "TODO: ask type and prefix message with it";
fi

