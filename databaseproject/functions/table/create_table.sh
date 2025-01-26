#!/usr/bin/bash

source ../sec_functions.sh

function create_table() {
    read -r -p "Enter Table Name: " table
    table=$(echo "$table" | tr ' ' '_')

    if [[ -z "$table" ]]; then
        echo "Error: Table name cannot be empty!"
        return 1
    fi

    check_name "$table"
    if (( $? != 0 )); then
        return 1
    fi

    table_file="./$table"
    metadata_file="./$table.metadata"

    if [[ -f "$metadata_file" ]]; then
        echo "Error: Table '$table' already exists!"
        return 1
    fi

    touch "$metadata_file" "$table_file"
    echo "Table '$table' created successfully!"

    # Add columns and metadata
    while true; do
        read -r -p "Enter Number of Columns: " num_columns
        if [[ "$num_columns" =~ ^[0-9]+$ ]] && (( num_columns > 0 )); then
            break
        else
            echo "Error: Number of columns must be a positive integer!"
        fi
    done

    for (( i = 1; i <= num_columns; i++ )); do
        while true; do
            read -r -p "Enter Column $i Name (or type 'done' to finish): " column_name
            column_name=$(echo "$column_name" | tr ' ' '_')

            if [[ -z "$column_name" ]]; then
                echo "Error: Column name cannot be empty!"
                continue
            fi

            if [[ "$column_name" == "done" ]]; then
                echo "Table columns are complete."
                return 0
            fi

            # Validate column name
            if grep -q "^$column_name:" "$metadata_file"; then
                echo "Error: Column '$column_name' already exists!"
                continue
            fi

            # Prompt for column type
            while true; do
                read -r -p "Enter data type for $column_name (integer/string): " column_type
                column_type=$(echo "$column_type" | tr ' ' '_')

                if [[ -z "$column_type" ]]; then
                    echo "Error: Column type cannot be empty!"
                    continue
                fi

                if [[ "$column_type" != "string" && "$column_type" != "integer" ]]; then
                    echo "Error: Invalid data type. Allowed types are 'string' or 'integer'."
                    continue
                fi
                break
            done

            # Prompt for column constraints
            while true; do
                read -r -p "Enter column constraint for $column_name (PK, not_null, or leave empty): " column_constraints
                column_constraints=$(echo "$column_constraints" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

                if [[ -z "$column_constraints" ]]; then
                    echo "No constraints added."
                    break
                elif [[ "$column_constraints" == "pk" || "$column_constraints" == "not_null" ]]; then
                    echo "Valid constraint added."
                    break
                else
                    echo "Error: Invalid constraint. Allowed constraints are 'PK', 'not_null', or leave empty."
                fi
            done

            # Write column metadata to file
            echo "$column_name:$column_type:$column_constraints" >> "$metadata_file"
            echo "Column '$column_name' added successfully!"
            break
        done
    done
}