#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/EazyPayZA/EazyPayZA/releases/download/1.0.0/eazypayza-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf eazypayza-1.0.0-x86_64-linux-gnu.tar.gz
rm -rf eazypayza-1.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 5566/tcp
  
cd
mkdir -p .eazypayza
echo "staking=1" >> eazypayza.conf
echo "rpcuser=user"`shuf -i 50000-5000000 -n 1` >> eazypayza.conf
echo "rpcpassword=pass"`shuf -i 50000-5000000 -n 1` >> eazypayza.conf
echo "rpcallowip=127.0.0.1" >> eazypayza.conf
echo "listen=1" >> eazypayza.conf
echo "server=1" >> eazypayza.conf
echo "daemon=1" >> eazypayza.conf
echo "logtimestamps=1" >> eazypayza.conf
echo "maxconnections=256" >> eazypayza.conf
echo "addnode=173.208.215.11" >> eazypayza.conf
echo "addnode=173.208.215.12" >> eazypayza.conf
echo "addnode=173.208.215.13" >> eazypayza.conf
echo "addnode=173.208.215.14" >> eazypayza.conf
echo "port=5566" >> eazypayza.conf
mv eazypayza.conf .eazypayza

  
cd
./eazypayzad -daemon
sleep 30
./eazypayza-cli getinfo
sleep 5
./eazypayza-cli getnewaddress
echo "Use the address above to send your EZPAY coins to this server"

