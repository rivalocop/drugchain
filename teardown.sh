sudo docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml -f docker-compose-couch.yaml -f docker-compose-ca.yaml down
sudo docker volume prune -f
sudo docker rmi $(docker images | grep 'dev-peer0') -f
sudo docker system prune -f
sudo rm -rf crypto-config/*
sudo rm -rf channel-artifacts/*