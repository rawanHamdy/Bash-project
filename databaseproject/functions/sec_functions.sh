#!/usr/bin/bash

shopt -s extglob

function check_name() {
    if [[ $1 = [0-9]* ]]; then
        echo "Error: Not a valid Database name!"
        return 1
    else
        case $1 in
            +([a-zA-Z_0-9]))
                return 0
                ;;
            *)
                echo "Error: DB Name Can't Contain Special Character"
                return 1
                ;;
        esac
    fi
}