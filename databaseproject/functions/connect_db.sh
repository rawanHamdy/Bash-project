#!/usr/bin/bash

source functions/sec_functions.sh

function connect_db() {
    read -r -p "Enter Database Name: " db
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

    echo "Entering '$db' database..."
    sleep 1

    # Change to the database directory
    cd "$db_dir"

    # Change to the table scripts directory before calling table_menu.sh
    cd ../../functions/table/

    # Call the table menu
    source ./table_menu.sh
    table_menu
}