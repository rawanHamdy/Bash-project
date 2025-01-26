#!/usr/bin/bash

source functions/sec_functions.sh

function create_db() {
    read -r -p "Enter Database Name: " db
    db=$(echo "$db" | tr ' ' '_')  # Replace spaces with underscores

    if [[ -z "$db" ]]; then
        echo "Error: Database name cannot be empty!"
        return 1
    fi

    check_name "$db"
    if (( $? != 0 )); then
        return 1
    fi

    db_dir="./databases/$db"

    if [[ -d "$db_dir" ]]; then
        echo "Error: Database '$db' already exists!"
        return 1
    fi

    mkdir -p "$db_dir"
    echo "Database '$db' created successfully!"
    sleep 1
}