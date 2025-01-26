#!/usr/bin/bash

function insert_row() {
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
    metadata_file="$db_dir/$table.metadata"

    if [[ ! -f "$metadata_file" ]]; then
        echo "Error: Table '$table' does not exist!"
        return 1
    fi

    # Read column names and types from metadata
    columns=()
    types=()
    constraints=()
    while IFS=: read -r col_name col_type col_constraint; do
        columns+=("$col_name")
        types+=("$col_type")
        constraints+=("$col_constraint")
    done < "$metadata_file"

    # Prompt for row data
    row_data=()
    for (( i = 0; i < ${#columns[@]}; i++ )); do
        while true; do
            read -r -p "Enter value for ${columns[$i]} (${types[$i]}): " value
            if [[ -z "$value" && "${constraints[$i]}" == "not_null" ]]; then
                echo "Error: ${columns[$i]} cannot be null!"
                continue
            fi

            if [[ "${types[$i]}" == "integer" && ! "$value" =~ ^[0-9]+$ ]]; then
                echo "Error: ${columns[$i]} must be an integer!"
                continue
            fi

            row_data+=("$value")
            break
        done
    done

    # Write row data to table file
    echo "${row_data[*]}" | tr ' ' ':' >> "$table_file"
    echo "Row inserted successfully!"
}