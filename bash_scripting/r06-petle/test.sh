#!/bin/bash

for i in $(find /tmp/t3 -perm /u+s) ; do
        if [[ "$i" == *"su"* ]] ; then
                echo "SU"
                continue;
        fi
        if [[ "$i" == *"mount"* ]] ; then
                echo "MOUNT"
                break;
        fi

done

