# PCI Host Device

## Add both of these outside "source" section and inside "hostdev" section

### Add patched rom
    <rom file="/usr/share/vgabios/patched.rom"/>

### Enable multifunction in both GPU and GPU's audio controller
    <address type="pci" domain="0x0000" bus="0x00" slot="0x00" function="0x0" multifunction="on"/>
