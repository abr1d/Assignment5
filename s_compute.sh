#correct permissions, start service
sudo chown -R munge: /etc/munge/ /var/log/munge/
sudo chmod 0700 /etc/munge/ /var/log/munge/
sudo systemctl enable munge
sudo systemctl start munge


#install more prereqs
sudo yum install openssl openssl-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel man2html libibmad libibumad -y


#install rmpbuild
sudo yum install rpm-build
sudo rpmbuild -ta slurm-15.08.9.tar.bz2

#install the RPMS
sudo yum -y --nogpgcheck localinstall slurm-15.08.9-1.el7.centos.x86_64.rpm slurm-devel-15.08.9-1.el7.centos.x86_64.rpm slurm-munge-15.08.9-1.el7.centos.x86_64.rpm slurm-perlapi-15.08.9-1.el7.centos.x86_64.rpm slurm-plugins-15.08.9-1.el7.centos.x86_64.rpm slurm-sjobexit-15.08.9-1.el7.centos.x86_64.rpm slurm-sjstat-15.08.9-1.el7.centos.x86_64.rpm slurm-torque-15.08.9-1.el7.centos.x86_64.rpm
