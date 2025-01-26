#!/usr/bin/bash

function list_tables() {
    if [[ -z "$(ls -A .)" ]]; then #lists all except . & ..
        echo "No tables found in the current database."
    else
        echo "Tables in the current database:"
        ls -1 | grep -v ".metadata$" | grep -v  ".sh$"
        #lists all in new lines then> -v > everything except matching patterns.
    fi
}