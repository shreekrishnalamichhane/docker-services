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

            # Bring down containers (optional)
            docker compose down
            if [ $? -eq 0 ]; then
                echo -e "Successfully stopped containers"  # Green text
            else
                echo -e "Failed to stop containers"  # Red text
            fi

            # Pull latest images
            docker compose pull
            if [ $? -eq 0 ]; then
                echo -e "Successfully pulled latest images"  # Green text
            else
                echo -e "Failed to pull images"  # Red text
            fi

            # Start services in detached mode
            docker compose up -d
            if [ $? -eq 0 ]; then
                echo -e "Successfully started containers"  # Green text
            else
                echo -e "Failed to start containers"  # Red text
            fi

        else
        echo -e "No compose.yml found in $dir, skipping..."
        fi
        
        # Return to the base directory before going to the next folder
        cd "$BASE_DIR"
    fi
done
