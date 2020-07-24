#!/bin/bash

which -s percol
if [ $? -eq 0 ]; then
    interactive_helper="percol"
fi

which -s peco
if [ $? -eq "0" ]; then
    interactive_helper="peco"
fi

if [ ${interactive_helper} == "" ]; then
    echo "abort: peco or percol requires to run"
    exit 1
fi

displayresolutionselect=$(
    displayplacer.new list |
    awk '$0 ~ /^id:/ { print }' |
    $interactive_helper
)

displayplacerparam=$(
    echo $displayresolutionselect |
    /usr/bin/awk '{ print $1" "$2 }'
)

displayplacer "${displayplacerparam}"
echo "change to \"${displayresolutionselect}\""

