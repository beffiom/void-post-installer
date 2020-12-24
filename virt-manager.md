#network
virsh -c qemu:///system net-autostart default
virsh -c qemu:///system net-start default

#passthrough
type: mount
driver: path
mode: passthrough
write policy: immediate

sudo mount -t 9p -o trans=virtio,version=9p2000.L /hostshare share

#pulse audio passthrough
1. doas nvim /etc/libvirt/qemu.conf
2. change `user = "root"` to your username in place of root
3. sudo EDITOR=nvim virsh edit vmname
4. edit `<domain type='kvm'>` to `<domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>`
5. at the very bottom change
  </devices>
</domain>

to

  </devices>
      <qemu:commandline>
        <qemu:arg value="-audiodev"/>
        <qemu:arg value="pa,id=snd0,server=/run/pulse/native"/>
      </qemu:commandline>
</domain>
