make clean
make modules -j"$(nproc)"
sudo make modules_install -j"$(nproc)"
sudo depmod -a

# stop services that may use GPU
sudo systemctl stop google-cloud-ops-agent google-cloud-ops-agent-otel-collector google-cloud-ops-agent-fluent-bit 2>/dev/null || true
sudo systemctl stop nvidia-persistenced 2>/dev/null || true

# remove old modules (ignore errors)
sudo rmmod nvidia-drm nvidia-uvm nvidia-peermem nvidia-modeset nvidia 2>/dev/null || true

sudo modprobe nvidia
sudo modprobe nvidia-modeset
sudo modprobe nvidia-uvm
sudo modprobe nvidia-drm

sudo dmesg | tail -n 200 | grep RYAN_MPS_OK
