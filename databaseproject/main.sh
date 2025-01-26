#!/usr/bin/bash

# Source database functions
source functions/create_db.sh
source functions/connect_db.sh
source functions/list_db.sh
source functions/remove_db.sh
source functions/sec_functions.sh

# Set up environment
LC_COLLATE=C  # Make the terminal case sensitive
shopt -s extglob  # Enable extended globbing patterns
export PS3="Your Database Choice: "  # Customize the select prompt

# Database directory (using relative path)
db_dir="./databases"

# Create the database directory if it doesn't exist
if [[ -d "$db_dir" ]]; then
    echo "Database Directory Already Exists"
else
    echo "Creating Database Folder..."
    mkdir -p "$db_dir"
    sleep 2
fi

# Main menu loop
while true; do
    select choice in CreateDB ConnectDB ListDB RemoveDB Exit; do
        case $choice in
            CreateDB)
                create_db
                ;;
            ConnectDB)
                connect_db
                ;;
            ListDB)
                list_db
                ;;
            RemoveDB)
                remove_db
                ;;
            Exit)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Not a valid choice. Please choose one of the available options only."
                ;;
        esac
        break  # Break the select loop to show the menu again
    done
done