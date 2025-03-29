echo
echo "Don't run this script"
echo

exit 0

# Run these 2 commands first
# openssl req -newkey rsa:2048 -nodes -keyout PKpriv.key -x509 -days 365 -out PK.crt
# openssl x509 -in PK.crt -outform der -out PK.der

openssl req -x509 -newkey rsa:2048 -outform PEM -keyout PkKek1.private.key -out PkKek1.pem
sed -e 's/^-----BEGIN CERTIFICATE-----$/4e32566d-8e9e-4f52-81d3-5bb9715f9727:/' -e '/^-----END CERTIFICATE-----$/d' PkKek1.pem | tr -d '\n' > PkKek1.oemstr

  <qemu:commandline>
    <qemu:arg value="-smbios"/>
    <qemu:arg value="type=11,path=/mnt/STORAGE/ISOs/Windows/PkKek1.oemstr"/>
  </qemu:commandline>

virsh start VM_NAME --reset-nvram

# # Download Microsoft Certificates
# # https://go.microsoft.com/fwlink/p/?linkid=321185
# # https://go.microsoft.com/fwlink/?LinkId=321192
#
# # Run commands below
# dd if=/dev/zero of=keys.img bs=4M count=1
# mkfs.vfat keys.img
# sudo losetup /dev/loopX keys.img
# sudo mount /dev/loopX /mnt
# cp PK.der /mnt/PK.der
# cp MicCorKEKCA2011_2011-06-24.crt /mnt/KEK.crt
# cp MicWinProPCA2011_2011-10-19.crt /mnt/DB.crt
# sudo umount /dev/loopX
# sudo losetup -d /dev/loopX
#
# # When you're done
# # Add "keys.img" as a Storage Device in QEMU
# # Go to the VM's UEFI, go to "Device Manager"->"Secure Boot Configuration"
# # Change "Secure Boot Mode" from Standard to Custom Mode, go to Custom Secure Boot Options
# # Go to PK Options, Enroll PK then Enroll PK Using File
# # Locate the Disk Drive, then select PK.der and "Commit Changes and Exit"
# # Now go back and choose
# # Go to KEK Options, Enroll KEK then Enroll KEK Using File
# # Locate the Disk Drive, then select MicCorKEKCA2011_2011-06-24.crt and "Commit Changes and Exit"
# # Now go back and choose
# # Go to DB Options, Enroll Signature then Enroll Signature Using File
# # Locate the Disk Drive, then select MicWinProPCA2011_2011-10-19.crt and "Commit Changes and Exit"
