#!/bin/bash
sudo yum install -y oracle-instantclient-release-el9
sudo yum install -y oracle-instantclient19.19-basic oracle-instantclient19.19-devel oracle-instantclient19.19-jdbc oracle-instantclient19.19-sqlplus
sudo yum install -y perl-CPAN
sudo yum install -y postgresql
sudo yum install -y perl-DBD-Pg
sudo yum update -y

# Define the Oracle Home directory
export ORACLE_HOME=/usr/lib/oracle/19.19/client64
export LD_LIBRARY_PATH=/usr/lib/oracle/19.19/client64/lib

# Add Oracle Home to .bash_profile if not already present
if ! grep -q "ORACLE_HOME" ~/.bash_profile; then
    echo "export ORACLE_HOME=$ORACLE_HOME" >> ~/.bash_profile
    echo "Oracle Home added to .bash_profile"
else
    echo "Oracle Home is already set in .bash_profile"
fi

# Add Oracle Home to .bash_profile if not already present
if ! grep -q "LD_LIBRARY_PATH" ~/.bash_profile; then
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> ~/.bash_profile
    echo "LD_LIBRARY_PATH added to .bash_profile"
else
    echo "LD_LIBRARY_PATH is already set in .bash_profile"
fi


# Pre-configure CPAN to accept default settings
(echo y; echo o conf init) | sudo cpan
sudo perl -MCPAN -e 'install DBD::Oracle'


#install ora2pg
wget https://github.com/darold/ora2pg/archive/refs/tags/v24.3.tar.gz
# Extract the tar.gz file
tar -xvzf v24.3.tar.gz

# Change to the extracted directory
cd ora2pg-24.3

# Run the Perl Makefile script and install
sudo perl Makefile.PL
sudo make && sudo make install