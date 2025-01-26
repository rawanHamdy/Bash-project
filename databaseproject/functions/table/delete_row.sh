#!/usr/bin/bash

function delete_row() {
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

    # Display current rows
    echo "Current rows in table '$table':"
    cat "$table_file" | nl | tr ':' ' '

    read -r -p "Enter Row Number to Delete: " row_number
    if [[ ! "$row_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid row number!"
        return 1
    fi

    # Delete the specified row
    sed -i "${row_number}d" "$table_file"
    echo "Row $row_number deleted successfully!"
}