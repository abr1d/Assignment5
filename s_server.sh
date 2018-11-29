#create secret key
sudo /usr/sbin/create-munge-key -r
sudo dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key
sudo chown munge: /etc/munge/munge.key
sudo chmod 400 /etc/munge/munge.key

#send key to compute nodes
sudo scp /etc/munge/munge.key root@compute-1:/etc/munge
sudo scp /etc/munge/munge.key root@compute-2:/etc/munge
sudo scp /etc/munge/munge.key root@compute-3:/etc/munge
sudo scp /etc/munge/munge.key root@compute-4:/etc/munge
sudo scp /etc/munge/munge.key root@compute-5:/etc/munge
sudo scp /etc/munge/munge.key root@compute-6:/etc/munge
sudo scp /etc/munge/munge.key root@compute-7:/etc/munge
sudo scp /etc/munge/munge.key root@compute-8:/etc/munge
sudo scp /etc/munge/munge.key root@compute-9:/etc/munge
sudo scp /etc/munge/munge.key root@compute-10:/etc/munge
sudo scp /etc/munge/munge.key root@compute-11:/etc/munge
sudo scp /etc/munge/munge.key root@compute-12:/etc/munge

#correct permissions, start service
sudo chown -R munge: /etc/munge/ /var/log/munge/
sudo chmod 0700 /etc/munge/ /var/log/munge/
sudo systemctl enable munge
sudo systemctl start munge

#install more prereqs
sudo yum install openssl openssl-devel pam-devel numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel man2html libibmad libibumad -y

#download slurm to shared folder
sudo cd /software
sudo wget http://www.schedmd.com/download/latest/slurm-15.08.9.tar.bz2

#install rmpbuild
sudo yum install rpm-build
sudo rpmbuild -ta slurm-15.08.9.tar.bz2

#make / move rpms
sudo mkdir /nfs/slurm-rpms
sudo cp slurm-15.08.9-1.el7.centos.x86_64.rpm slurm-devel-15.08.9-1.el7.centos.x86_64.rpm slurm-munge-15.08.9-1.el7.centos.x86_64.rpm slurm-perlapi-15.08.9-1.el7.centos.x86_64.rpm slurm-plugins-15.08.9-1.el7.centos.x86_64.rpm slurm-sjobexit-15.08.9-1.el7.centos.x86_64.rpm slurm-sjstat-15.08.9-1.el7.centos.x86_64.rpm slurm-torque-15.08.9-1.el7.centos.x86_64.rpm /nfs/slurm-rpms


#install the RPMS
sudo yum -y --nogpgcheck localinstall slurm-15.08.9-1.el7.centos.x86_64.rpm slurm-devel-15.08.9-1.el7.centos.x86_64.rpm slurm-munge-15.08.9-1.el7.centos.x86_64.rpm slurm-perlapi-15.08.9-1.el7.centos.x86_64.rpm slurm-plugins-15.08.9-1.el7.centos.x86_64.rpm slurm-sjobexit-15.08.9-1.el7.centos.x86_64.rpm slurm-sjstat-15.08.9-1.el7.centos.x86_64.rpm slurm-torque-15.08.9-1.el7.centos.x86_64.rpm

#set some more services :)
sudo systemctl enable slurmctld.service
sudo systemctl start slurmctld.service
sudo systemctl status slurmctld.service

#setup dem files
sudo mkdir /var/spool/slurmctld
sudo chown slurm: /var/spool/slurmctld
sudo chmod 755 /var/spool/slurmctld
sudo touch /var/log/slurmctld.log
sudo chown slurm: /var/log/slurmctld.log
sudo touch /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log
sudo chown slurm: /var/log/slurm_jobacct.log /var/log/slurm_jobcomp.log

