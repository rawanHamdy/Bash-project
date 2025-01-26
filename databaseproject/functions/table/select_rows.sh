#!/usr/bin/bash

function select_rows() {
    # Prompt for the database name
    read -r -p "Enter Database Name: " db
    db=$(echo "$db" | tr ' ' '_')

    # Define the database directory
    db_dir="$HOME/.Database/$db"

    if [[ ! -d "$db_dir" ]]; then
        echo "Error: Database '$db' does not exist!"
        return 1
    fi

    read -r -p "Enter Table Name: " table
    table=$(echo "$table" | tr ' ' '_')

    if [[ -z "$table" ]]; then
        echo "Error: Table name cannot be empty!"
        return 1
    fi

    table_file="$db_dir/$table.data"

    if [[ ! -f "$table_file" ]]; then
        echo "Error: Table '$table' does not exist!"
        return 1
    fi

    echo "Rows in table '$table':"
    cat "$table_file" | tr ':' ' '
}