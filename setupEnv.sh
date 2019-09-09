echo "Install docker"
echo "Check older docker version"
sudo apt-get remove docker docker-engine docker.io containerd runc

echo "Install docker engine"
sudo apt-get update

echo "Install some packages dependency"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "Add Docker's offical GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Verify GPG"
sudo apt-key fingerprint 0EBFCD88

echo "Add stable repository"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "Install docker"
sudo apt-get update
echo "Install latest docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io
echo "Verify docker"
sudo docker run hello-world

echo "sleep 5"
sleep 5

echo "Install Golang"
echo "Create go workspace"
mkdir -p $HOME/go
echo "set path variable env for golang"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
source $HOME/.zshrc

echo "Install python"
sudo apt-get install python

echo "Install nodejs"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y build-essential
sudo apt-get install -y nodejs

echo "Install binary"
mkdir -p $HOME/drugchain
cd $HOME/drugchain-network
git clone https://github.com/rivalocop/drugchain.git drugchain-network
echo "Pulling binaries and docker images 1.4.3 version"
curl https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh | bash -s -- 1.4.3 1.4.3 -s
