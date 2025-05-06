#!/bin/bash

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to each directory within the base folder
for dir in "$BASE_DIR"/*/; do
    if [ -d "$dir" ]; then
        echo "=================================================="
        echo -e "Service : $dir"
        echo "=================================================="
        cd "$dir"

        # Check if a compose.yml file exists
        if [ -f "compose.yml" ]; then

            # Start services in detached mode
            docker compose up -d
            if [ $? -eq 0 ]; then
                echo -e "Successfully started containers"
            else
                echo -e "Failed to start containers"
            fi

        else
        echo -e "No compose.yml found in $dir, skipping..."
        fi
        
        # Return to the base directory before going to the next folder
        cd "$BASE_DIR"
    fi
done
