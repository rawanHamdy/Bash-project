#!/usr/bin/bash

function drop_table() {
    read -r -p "Enter Table Name to Drop: " table
    table=$(echo "$table" | tr ' ' '_')

    if [[ -z "$table" ]]; then
        echo "Error: Table name cannot be empty!"
        return 1
    fi

    table_file="../../databases/$table"
    metadata_file="../../databases/$table.metadata"

    if [[ ! -f "$metadata_file" ]]; then
        echo "Error: Table '$table' does not exist!"
        return 1
    fi

    rm "$metadata_file" "$table_file"
    echo "Table '$table' dropped successfully!"
}