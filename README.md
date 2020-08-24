# vmware-thin-mover
## Summary
A script that copies/moves Thin-provisioned VMs without converting them to thick.

## Usage instructions
1. Unregister specified VM from the virtual machine list
2. Migrate the files with the move_vm.sh
3. Re-import the VM from the new datastore

Script syntax: move_vm.sh origin_datastore vm_name destination_datastore

## Example

    VMWare Thin VM migration script written by manatails
    Version 1.0
    Moving VM testvm from datastore 500GB EVO to VM testvm at datastore RAID
    Creating destination directory...
    Copying VMDK file...
    Destination disk format: VMFS thin-provisioned
    Cloning disk '/vmfs/volumes/500GB EVO/testvm/testvm.vmdk'...
    Clone: 100% done.
    Copying extra VMDK file...
    Copying other files...
    Copying snapshots...
    Copy finished.
    Remove origin VM files from disk (y/n)? y
    Removing origin VM files...
    Migration finished.
