#!/usr/bin/bash

function select_rows() {
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

    echo "Rows in table '$table':"
    cat "$table_file" | tr ':' ' '
}