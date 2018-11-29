#install mariadb
sudo yum install mariadb-server mariadb-devel -y

# global users
sudo export MUNGEUSER=991
sudo groupadd -g $MUNGEUSER munge
sudo useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
sudo export SLURMUSER=992
sudo groupadd -g $SLURMUSER slurm
sudo useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm

#install munge
sudo yum install epel-release -y
sudo yum install munge munge-libs munge-devel -y

#install rng tools, create a key
sudo yum install rng-tools -y
sudo rngd -r /dev/urandom
