#!/bin/sh
set -e

VERSION="1.1"

echo "VMWare Thin VM bulk migration script"
echo "Version $VERSION"

print_help() {
    echo "Syntax: bulk_copy_datastore_vms.sh origin_datastore destination_datastore"
}

if [ -z "$2" ]; then
    echo "Insufficient number of arguments."
    print_help
    exit 1
fi

if [ ! -z "$3" ]; then
    echo "Too many arguments."
    print_help
    exit 1
fi

ORIGIN_DATASTORE="$1"
DESTINATION_DATASTORE="$2"

if [ ! -d "/vmfs/volumes/$ORIGIN_DATASTORE" ]; then
    echo "Unable to find origin datastore $ORIGIN_DATASTORE"
    exit 1
fi

if [ ! -d "/vmfs/volumes/$DESTINATION_DATASTORE" ]; then
    echo "Unable to find destination datastore $DESTINATION_DATASTORE"
    exit 1
fi

for VM_DIR in /vmfs/volumes/"$ORIGIN_DATASTORE"/*; do
    if [ -d "$VM_DIR" ]; then
        VM_NAME=$(basename "$VM_DIR")
        if [ -d "/vmfs/volumes/$DESTINATION_DATASTORE/$VM_NAME" ]; then
            echo "Skipping VM $VM_NAME: already exists in destination datastore $DESTINATION_DATASTORE"
            continue
        fi
        echo "Copying VM $VM_NAME from $ORIGIN_DATASTORE to $DESTINATION_DATASTORE"
        ./copy_vm.sh "$ORIGIN_DATASTORE" "$VM_NAME" "$DESTINATION_DATASTORE"
        echo "Copy of VM $VM_NAME completed."
    fi
done

echo "All eligible VMs have been migrated from $ORIGIN_DATASTORE to $DESTINATION_DATASTORE."

