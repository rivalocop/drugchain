echo "Install docker"
echo "Check older docker version"
sudo apt-get remove docker docker-engine docker.io containerd runc

echo "Install docker engine"
sudo apt-get update

echo "Install some packages dependency"
sudo apt-get install -y \
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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo "Verify docker"
sudo docker run hello-world

echo "Install docker-compose"
echo "Get current stable docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo "Apply excutable for binary"
sudo chmod +x /usr/local/bin/docker-compose
echo "Verify docker-compose"
docker-compose --version

echo "sleep 3"
sleep 3

echo "Install Golang"
echo "Create go workspace"
mkdir -p $HOME/go
echo "Add repository golang"
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
echo "Install Golang"
sudo apt-get install -y golang-go
echo "set path variable env for golang"
export GOROOT=/usr/bin/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
source $HOME/.zshrc
echo "sleep 3"
sleep 3

echo "Install python"
sudo apt-get install -y python

echo "Install nodejs"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y build-essential
sudo apt-get install -y nodejs

echo "Install binary"
mkdir -p $HOME/drugchain
cd $HOME/drugchain
git clone https://github.com/rivalocop/drugchain.git drugchain-network
echo "Pulling binaries and docker images 1.4.2 version"
curl https://raw.githubusercontent.com/rivalocop/drugchain/master/bootstrap.sh | bash -s -- 1.4.2 1.4.2 -s

echo "Make channel-artifact directory"
mkdir -p $HOME/drugchain/drugchain-network/channel-artifacts
