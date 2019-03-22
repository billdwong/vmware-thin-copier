#!/bin/sh
set -e

echo "#####################################"
echo "###VMWare Thin VM migration script###"
echo "#####################################"
echo "#########Author: manatails###########"
echo "#####################################"

print_help() {
	echo "Syntax: move_vm.sh origin_datastore vm_name destination_datastore"
}

if [ -z "$3" ]
  then
    echo "Insufficent arguments."
	print_help
	exit 1
fi

if [ ! -z "$4" ]
  then
    echo "Too many arguments."
	print_help
	exit 1
fi

echo "Moving VM $2 from datastore $1 to VM $2 at datastore $3"

if [ ! -d "/vmfs/volumes/$1/$2" ]
then
    echo "Unable to find VM $2 on datastore $1" 
    exit 1
fi

if [ -d "/vmfs/volumes/$3/$2" ]
then
    echo "VM $2 already exists on datastore $3" 
    exit 1
fi

echo "Creating destination directory..."
mkdir "/vmfs/volumes/$3/$2"

echo "Copying VMDK file..."
vmkfstools -i "/vmfs/volumes/$1/$2/$2.vmdk" -d thin "/vmfs/volumes/$3/$2/$2.vmdk"

echo "Copying other files..."
find "/vmfs/volumes/$1/$2" -maxdepth 1 -type f | grep -v ".vmdk" | while read file; do cp "$file" "/vmfs/volumes/$3/$2"; done

echo "Copying snapshots..."
find "/vmfs/volumes/$1/$2" -maxdepth 1 -type f | grep [0123456789][0123456789][0123456789][0123456789][0123456789][0123456789] | grep ".vmdk" | while read file; do cp "$file" "/vmfs/volumes/$3/$2"; done

echo "copy finished."
read -p "Delete the original VM (y/n)? " CONT
if [ "$CONT" = "y" ]; then
  echo "Removing origin VM..."
  rm -rf "/vmfs/volumes/$1/$2"
fi

echo "Migration finished."
