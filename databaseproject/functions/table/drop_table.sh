#!/usr/bin/bash

function drop_table() {
    # Prompt for the database name
    read -r -p "Enter Database Name: " db
    db=$(echo "$db" | tr ' ' '_')

    # Define the database directory
    db_dir="$HOME/.Database/$db"

    if [[ ! -d "$db_dir" ]]; then
        echo "Error: Database '$db' does not exist!"
        return 1
    fi

    read -r -p "Enter Table Name to Drop: " table
    table=$(echo "$table" | tr ' ' '_')

    if [[ -z "$table" ]]; then
        echo "Error: Table name cannot be empty!"
        return 1
    fi

    table_file="$db_dir/$table.data"
    metadata_file="$db_dir/$table.metadata"

    if [[ ! -f "$metadata_file" ]]; then
        echo "Error: Table '$table' does not exist!"
        return 1
    fi

    # Remove the table and its metadata
    rm "$metadata_file" "$table_file"
    echo "Table '$table' dropped successfully!"
}