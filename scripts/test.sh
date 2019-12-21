#!/bin/sh

echo $HUSKY_GIT_PARAMS;
echo $2;
echo $3;


CURRENT_BRANCH=`git branch | grep \* | cut -d' ' -f2`;

echo $CURRENT_BRANCH;
