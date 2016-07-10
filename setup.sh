#!/bin/bash
# vim: ft=bash sw=2 ts=2 expandtab

DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -n "Perfered language type 'python' or 'ruby' and hit [ENTER]: "
read language

grep -i 'python' <<< $language > /dev/null
if [ $? == 0 ]; then
  LANGUAGE='python'
fi

grep -i 'ruby' <<< $language > /dev/null
if [ $? == 0 ]
then
  LANGUAGE='ruby'
fi

mkdir $DIRNAME/bin

if [[ "$LANGUAGE" == "python" ]]
then
  cp $DIRNAME/objects/examples/*.py $DIRNAME/objects
  chmod 750 $DIRNAME/objects/*.py
fi

if [[ "$LANGUAGE" == "ruby" ]]
then
  cp $DIRNAME/objects/examples/*.rb $DIRNAME/objects
  chmod 750 $DIRNAME/objects/*.rb
fi
