#!/bin/bash

# Check if all required parameters are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <START_ID> <END_ID> <TEMPLATE_ID>"
    echo "Please provide the START_ID, END_ID, and TEMPLATE_ID parameters."
    exit 1
fi

# Assign parameters to variables
START_ID=$1
END_ID=$2
TEMPLATE_ID=$3

# Confirm ID range
echo "You have entered the following parameters:"
echo "START_ID: $START_ID"
echo "END_ID: $END_ID"
echo "TEMPLATE_ID: $TEMPLATE_ID"
echo "Is this correct? (yes/no)"
read -r CONFIRMATION

if [[ "$CONFIRMATION" != "yes" ]]; then
    echo "Exiting script. Please restart with the correct parameters."
    exit 1
fi

# Script logic continues here
echo "Proceeding with START_ID=$START_ID, END_ID=$END_ID, TEMPLATE_ID=$TEMPLATE_ID."

# Clear the remain files
echo "Clearing..."
for ((i=$((START_ID)); i<=$((END_ID)); i++))
do
    dataset="data/vm-$i-cloudinit"
    zfs destroy "$dataset"
done
echo "Done"

# Create VMs
echo "Creating VMs..."
for ((VM_ID=$((START_ID)); VM_ID<=$((END_ID)); VM_ID++))
do
    qm clone "$TEMPLATE_ID" "$VM_ID" --name "vm-$VM_ID" 
    # qm start "$VM_ID"
    echo "VM $VM_ID created and configured."
    wait
done
echo "All VMs have been created and configured."