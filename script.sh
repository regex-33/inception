#!/bin/bash

# Step 1: Bring down services and remove orphan containers
echo "Bringing down services and removing orphan containers..."
sudo docker-compose down --remove-orphans

# Step 2: If the network cannot be removed due to active endpoints, disconnect them manually
# First, list all containers connected to the network (adjust network name as necessary)
network_name="srcs_regex-33"
containers=$(sudo docker network inspect $network_name -f '{{range .Containers}}{{.Name}} {{end}}')

if [ ! -z "$containers" ]; then
    echo "Manually disconnecting containers from the network..."
    for container in $containers; do
        sudo docker network disconnect -f $network_name $container
    done
fi

# Step 3: Try removing the network manually
echo "Attempting to remove the network manually..."
sudo docker network rm $network_name

# Step 4: Ensure all containers are stopped
echo "Ensuring all containers are stopped..."
sudo docker-compose stop
sudo docker stop $(sudo docker ps -aq)

# Step 5: Retry bringing down services
echo "Retrying to bring down services..."
sudo docker-compose down --remove-orphans

echo "Script execution completed."