# Make VM recognize drive as SSD

## Detect your domains

    virsh list --all

### You may need to append "-c xxx:///yyy" before "list" like shown below

    -c lxc:///
    -c qemu:///system

### So it'll look like

    virsh -c qemu:///system list --all

## Detect your VM's HD ID

    virsh qemu-monitor-command win10 --hmp "info qtree" | grep 'ide-hd'

### Note: If you had to use the -c (--connect) command in the virsh list above you'll also need to append them to the qemu-monitor-command aswell like so

    virsh -c qemu:///system qemu-monitor-command win10 --hmp "info qtree" | grep 'ide-hd'

### It'll output something like this, the "0" may vary if you have more than one HD so you'll have to check which one is the right one:

    dev: ide-hd, id "sata0-0-0"
    dev: ide-hd, id "sata0-0-0-0"
    dev: ide-hd, id "scsi0-0-0"
    dev: ide-hd, id "scsi0-0-0-0"

## Now just edit the XML

# Old Method

    <domain xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0" type="kvm">
    ...
      <qemu:commandline>
        <qemu:arg value='-set'/>
        <qemu:arg value='device.sata0-0-0.rotation_rate=1'/>
      </qemu:commandline>
    </domain>

# New method

    <domain xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0" type="kvm">
    ...
      <qemu:override>
        <qemu:device alias="sata0-0-0">
          <qemu:frontend>
            <qemu:property name="rotation_rate" type="unsigned" value="1"/>
          </qemu:frontend>
        </qemu:device>
      </qemu:override>
    </domain>
