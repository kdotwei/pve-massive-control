#!/bin/bash

# Parameters
START_ID=$1
END_ID=$2

# Check if both parameters are provided
if [ -z "$START_ID" ] || [ -z "$END_ID" ]; then
    echo "Usage: $0 <START_ID> <END_ID>"
    echo "Please provide the START_ID and END_ID parameters."
    exit 1
fi

# Destroy VMs
echo "Deleting VMs..."
for ((i=$((START_ID)); i<=$((END_ID)); i++))
do
    qm destroy "$i"
done
echo "VMs Deleted"

# Clear the dataset
echo "Clearing datasets..."
for ((i=$((START_ID)); i<=$((END_ID)); i++))
do
    dataset="data/vm-$i-cloudinit"
    zfs destroy "$dataset"
done
echo "Done"