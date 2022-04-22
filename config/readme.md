# Configuration tracking repository

This tree tracks the configuration changes made by the automation system.



Ulogd

```none
eperry@rpi-edge-a ~ $ sudo rpm-ostree install setroubleshoot setools --apply-live
eperry@rpi-edge-a ~ $ sudo systemctl start auditd
eperry@rpi-edge-a ~ $ sudo systemctl restart ulogd

    failure message

eperry@rpi-edge-a ~ $ sudo journalctl --no-pager --since today | grep avc  | grep -i ulogd| audit2allow


#============= ulogd_t ==============

#!!!! This avc can be allowed using the boolean 'domain_can_mmap_files'
allow ulogd_t etc_t:file map;
allow ulogd_t init_t:unix_stream_socket connectto;
allow ulogd_t passwd_file_t:file { getattr open read };
allow ulogd_t self:capability dac_override;
allow ulogd_t sssd_var_lib_t:dir search;
allow ulogd_t systemd_userdbd_runtime_t:dir read;
allow ulogd_t systemd_userdbd_runtime_t:lnk_file read;
allow ulogd_t systemd_userdbd_runtime_t:sock_file write;

#!!!! This avc can be allowed using the boolean 'daemons_enable_cluster_mode'
allow ulogd_t systemd_userdbd_t:unix_stream_socket connectto;
allow ulogd_t var_run_t:dir { add_name write };
allow ulogd_t var_run_t:file { create getattr lock open read write };
eperry@rpi-edge-a ~ $ sudo journalctl --no-pager --since today | grep avc  | grep -i ulogd| audit2allow -M ulogd2
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i ulogd2.pp

eperry@rpi-edge-a ~ $ sudo semodule -i ulogd2.pp
eperry@rpi-edge-a ~ $ sudo systemctl restart ulogd
```


setools
jansson-devel
setroubleshoot
selinux-policy-devel
policycoreutils-devel
gcc rpm-build rpm-devel rpmlint make python bash coreutils diffutils patch rpmdevtools fedora-packager fedora-review
libdbi-devel libmnl-devel libnetfilter_acct-devel libnetfilter_log-devel libnetfilter_conntrack-devel libpcap-devel mysql-devel postgresql-devel sgml-tools sqlite-devel zlib-devel

```shell
./prepare.sh

cp ulogd.conf /root/ulogd.spec/ulogd.conf
cp ulogd.service /root/ulogd.spec/ulogd.service
cp ulogd.logrotate /root/ulogd.spec/ulogd.logrotate

rpmbuild -ba ulogd.spec
fedpkg --release f35 local --arch aarch64
```

```shell
sudo sepolicy generate --init $(which ulogd)
./ulogd.sh
```
