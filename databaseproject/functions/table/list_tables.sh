#!/usr/bin/bash

function list_tables() {
    # Prompt for the database name
    read -r -p "Enter Database Name: " dbname
    dbname=$(echo "$dbname" | tr ' ' '_')

    # Define the database path
    db_path="$HOME/.Database/$dbname"

    # Check if the database exists
    if [[ ! -d "$db_path" ]]; then
        echo "Error: Database '$dbname' does not exist!"
        return 1
    fi

    # List tables in the specified database
    if [[ -z "$(ls -A "$db_path")" ]]; then
        echo "No tables found in database '$dbname'."
    else
        echo "Tables in database '$dbname':"
        ls -1 "$db_path" | grep -v ".metadata$" | grep -v ".sh$" | sed 's/.data$//'
        # Lists all files, excluding metadata and shell script files, and strips the .data extension.
    fi
}