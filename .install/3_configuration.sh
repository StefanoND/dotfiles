#!/bin/bash

if ! [ "$EUID" -ne 0 ]; then
    echo
    echo "Don't run this script as root."
    echo
    sleep 1s
    exit 1
fi

echo
echo "Setting up fq_pie queue discipline for TCP congestion control"
echo
echo 'net.core.default_qdisc = fq_pie' | sudo tee /etc/sysctl.d/90-override.conf
sleep 1s

echo
echo "Amending journald Logging to 200M"
echo
sudo sed -i "s|#SystemMaxUse=.*|SystemMaxUse=200M|g" /etc/systemd/journald.conf
sleep 1s

echo
echo "Setting MinimumVT to 7"
echo
sudo sed -i "s|MinimumVT=.*|MinimumVT=7|g" /usr/lib/sddm/sddm.conf.d/default.conf
sleep 1s

echo
echo "Restricting Kernel Log Access"
echo
sudo sysctl -w kernel.dmesg_restrict=1
sleep 1s

if ! [ -f "$HOME"/.tmux/plugins/tpm ]; then
  echo
  echo 'Cloning tmux plugin manager'
  echo
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  sleep 1s
fi

# Nvim
if ! [ -f /etc/sysctl.d/99-sysctl.conf ]; then
  sudo touch /etc/sysctl.d/99-sysctl.conf
fi

printf "fs.inotify.max_user_instances=1024\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.inotify.max_user_watches=524288\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.max_map_count=262144\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.tcp_fin_timeout=5\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sched_cfs_bandwidth_slice_us=3000\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.rmem_max=2621440\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.wmem_max=2621440\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
echo 'kernel.core_pattern=|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.core_pipe_limit=16\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.suid_dumpable=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sysrq=16\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.core_uses_pid=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.rp_filter=2\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.accept_source_route=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.default.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.docker0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.enp34s0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.lo.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.tun0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.vboxnet0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.conf.virbr0.promote_secondaries=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.ipv4.ping_group_range=0 2147483647\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "net.core.default_qdisc=fq_codel\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_hardlinks=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_symlinks=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_regular=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.protected_fifos=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.pid_max=4194304\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "fs.aio-max-nr=1048576\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.unprivileged_userfaultfd=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "vm.swappiness=133\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.nmi_watchdog=0\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.unprivileged_userns_clone=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.printk=3 3 3 3\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
printf "kernel.sysrq=1\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
sudo sysctl --system

exit 0
