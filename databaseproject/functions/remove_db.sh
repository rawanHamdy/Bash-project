#!/usr/bin/bash

source functions/sec_functions.sh

function remove_db() {
    read -r -p "Enter Database Name to remove: " db
    db=$(echo "$db" | tr ' ' '_')

    if [[ -z "$db" ]]; then
        echo "Error: Database name cannot be empty!"
        return 1
    fi

    check_name "$db"
    if (( $? != 0 )); then
        return 1
    fi

    db_dir="./databases/$db"

    if [[ ! -d "$db_dir" ]]; then
        echo "Error: Database '$db' does not exist!"
        return 1
    fi

    rm -r "$db_dir"
    echo "Database '$db' removed successfully!"
}