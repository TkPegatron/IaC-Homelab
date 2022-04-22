# Notes

```none
eperry@rpi-edge-a ~ $ sudo modprobe nfnetlink_log
eperry@rpi-edge-a ~ $ sudo lsmod | grep nfnetlink_log
nfnetlink_log          28672  0
nfnetlink              20480  2 nf_tables,nfnetlink_log
``
