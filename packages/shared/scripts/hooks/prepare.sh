#!/bin/bash

# Keep in sync with $PROJECT/packages/shared/scripts/path/readlinkf.sh
readlinkf() {
  TARGET_FILE=$1

  cd `dirname $TARGET_FILE`
  TARGET_FILE=`basename $TARGET_FILE`

  # Iterate down a (possible) chain of symlinks
  while [ -L "$TARGET_FILE" ]
  do
    TARGET_FILE=`readlink $TARGET_FILE`
    cd `dirname $TARGET_FILE`
    TARGET_FILE=`basename $TARGET_FILE`
  done

  # Compute the canonicalized name by finding the physical path 
  # for the directory we're in and appending the target file.
  PHYS_DIR=`pwd -P`
  RESULT=$PHYS_DIR/$TARGET_FILE
  echo $RESULT
}

PROJECT=`readlinkf "$(dirname "$(readlinkf "${BASH_SOURCE[0]}")")/../../../.."`
ENV_LIST_DIR="$PROJECT/packages/shared/resources/deployment"

if [[ ! -f "$ENV_LIST_DIR/.env" ]]; then
  cp "$ENV_LIST_DIR/.env"{.dist,}
fi
