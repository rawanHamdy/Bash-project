#!/usr/bin/bash

function list_db() {
    db_dir="./databases"

    if [[ ! -d "$db_dir" || -z "$(ls -A "$db_dir")" ]]; then
        echo "No databases found."
    else
        echo "List of databases:"
        ls -1 -F "$db_dir" | grep / | tr '/' ' '
    fi
}