#!/usr/bin/env bash

if [ $# -lt 1 ] ; then
	cat << USAGE
usage: $0: {Absolute file path to link with git-ed}
USAGE
	exit 0
fi

GIT_LINKER_FIRST_ARG="$1"
if [ ! -f "$GIT_LINKER_FIRST_ARG" ] ; then exit 254; fi

GIT_LINKER_CONFIG_STORE_DIR="${GIT_LINKER_CONFIG_STORE_DIR:-./}"
if [ ! -d "$GIT_LINKER_CONFIG_STORE_DIR" ] ;  then exit 255 ; fi

GIT_LINKER_ABSOLUTE_FROM_FILE_PATH="$GIT_LINKER_FIRST_ARG"
GIT_LINKER_RELATIVE_TO_FILE_NAME="$(basename $GIT_LINKER_ABSOLUTE_FROM_FILE_PATH } | sed -e 's/^[.]//')"

pushd "$GIT_LINKER_CONFIG_STORE_DIR" > /dev/null
echo 'mv '"$GIT_LINKER_ABSOLUTE_FROM_FILE_PATH" "$GIT_LINKER_RELATIVE_TO_FILE_NAME" '&&' ln -s "$(pwd)/$GIT_LINKER_RELATIVE_TO_FILE_NAME" "$GIT_LINKER_ABSOLUTE_FROM_FILE_PATH" '&& echo OK'
echo -n "is this Okay to execute? > "
read ANS
mv "$GIT_LINKER_ABSOLUTE_FROM_FILE_PATH" "$GIT_LINKER_RELATIVE_TO_FILE_NAME" && ln -s "$(pwd)/$GIT_LINKER_RELATIVE_TO_FILE_NAME" "$GIT_LINKER_ABSOLUTE_FROM_FILE_PATH" && echo OK
popd > /dev/null
exit 0
