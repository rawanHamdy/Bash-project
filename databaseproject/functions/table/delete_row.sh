#!/usr/bin/bash

function delete_row() {
    read -r -p "Enter Table Name: " table
    table=$(echo "$table" | tr ' ' '_')

    if [[ -z "$table" ]]; then
        echo "Error: Table name cannot be empty!"
        return 1
    fi

    table_file="./$table"

    if [[ ! -f "$table_file" ]]; then
        echo "Error: Table '$table' does not exist!"
        return 1
    fi

    read -r -p "Enter Row Number to Delete: " row_number
    if [[ ! "$row_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid row number!"
        return 1
    fi

    sed -i "${row_number}d" "$table_file"
    echo "Row $row_number deleted successfully!"
}