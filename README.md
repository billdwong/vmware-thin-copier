# vmware-thin-copier
## Summary
Scripts to copy VMs or datastores, converting volumes to thin-provisioned.

## Usage instructions
### Copying a single VM to a new datastore
1. Unregister specified VM from the virtual machine list
2. Copy the files with copy_vm.sh
3. Re-import the VM from the new datastore

Script usage: copy_vm.sh <source datastore> <vm> <destination datastore>

### Copying all VMs on a datastore to another datastore
Usage: bulk_copy_datastore_vms.sh <origin datastore> <destination datastore>


