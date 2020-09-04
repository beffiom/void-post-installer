#network
virsh -c qemu:///system net-autostart default
virsh -c qemu:///system net-start default

#passthrough
type: mount
driver: path
mode: passthrough
write policy: immediate

sudo mount -t 9p -o trans=virtio,version=9p2000.L /hostshare share

#configuration file
- sudo virsh edit Whonix-Gateway
- delete
 <blkiotune>
    <weight>250</weight>
</blkiotune>
