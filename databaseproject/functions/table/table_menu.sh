#!/usr/bin/bash

# Source table functions
source ./create_table.sh
source ./drop_table.sh
source ./list_tables.sh
source ./insert_row.sh
source ./select_rows.sh
source ./delete_row.sh

# Set up environment
export PS3="Your Choice: "  # Customize the select prompt

# Table menu loop
function table_menu() {
    while true; do
        select choice in CreateTable DropTable ListTables InsertRow SelectRows DeleteRow Exit; do
            case $choice in
                CreateTable)
                    create_table
                    ;;
                DropTable)
                    drop_table
                    ;;
                ListTables)
                    list_tables
                    ;;
                InsertRow)
                    insert_row
                    ;;
                SelectRows)
                    select_rows
                    ;;
                DeleteRow)
                    delete_row
                    ;;
                Exit)
                    echo "Exiting table menu..."
                    return 0  # Return to the main menu
                    ;;
                *)
                    echo "Not a valid choice. Please choose one of the available options only."
                    ;;
            esac
            break  # Break the select loop to show the menu again
        done
    done
}