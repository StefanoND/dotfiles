Copy paste from [RO1](https://unix.stackexchange.com/users/335636/ro1) in [Stack Exchange](https://unix.stackexchange.com/questions/464507/how-to-apply-qcow2-snapshot-to-overlay-raw-disk-image)'s post
#
Once you convert the raw disk to qcow2 format

    sudo qemu-img create -F raw -b image.img -f qcow2 image.qcow2

You can use QEMU's built-in tool or you can use virsh to create snapshots

    sudo virsh snapshot-create-as VMNAME snapshot_name snapshot_description

You can use QEMU's built-in tool or you can use virsh to revert snapshots

    sudo virsh snapshot-revert --domain VMNAME snapshot_name

You'll have to change your vm.img file to vm.qcow2 file as well as type="raw" to type="qcow2"
