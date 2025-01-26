#!/usr/bin/bash

function list_tables() {
    # Define the database directory path
    db_directory="../../databases"

    # Check if the database directory exists
    if [[ ! -d "$db_directory" ]]; then
        echo "Error: Database directory '$db_directory' does not exist!"
        return 1
    fi

    # List all tables in the database directory
    if [[ -z "$(ls -A "$db_directory")" ]]; then
        echo "No tables found in the database."
    else
        echo "Tables in the database:"
        ls -1 "$db_directory" | grep -v ".metadata$" | grep -v ".sh$"
        # Lists all files in the database directory, excluding metadata and shell script files.
    fi
}