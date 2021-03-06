echo "Generating crypto material"
../bin/cryptogen generate --config=./crypto-config.yaml

echo "Setting the project path"
FABRIC_CFG_PATH=$PWD

echo "Generating genesis block"
../bin/configtxgen -profile DrugchainOrdererGenesis -channelID drugchain-sys-channel -outputBlock ./channel-artifacts/genesis.block
echo "Generating artifact for drugtxchannel"
../bin/configtxgen -profile DrugTxChannel -outputCreateChannelTx ./channel-artifacts/drugtxchannel.tx -channelID drugtxchannel
echo "Generating artifact for distributorargchannel"
../bin/configtxgen -profile DistributorArgChannel -outputCreateChannelTx ./channel-artifacts/distributorargchannel.tx -channelID distributorargchannel
echo "Generating artifact for retailerargchannel"
../bin/configtxgen -profile RetailerArgChannel -outputCreateChannelTx ./channel-artifacts/retailerargchannel.tx -channelID retailerargchannel


echo "Configuaring anchor peer for ViePharmaCorp drugtxchannel"
../bin/configtxgen -profile DrugTxChannel -outputAnchorPeersUpdate ./channel-artifacts/ViePharmaCorpMSPanchors_drugtxchannel.tx -channelID drugtxchannel -asOrg ViePharmaCorpMSP
echo "Configuaring anchor peer for FeedexCorp drugtxchannel"
../bin/configtxgen -profile DrugTxChannel -outputAnchorPeersUpdate ./channel-artifacts/FeedexCorpMSPanchors_drugtxchannel.tx -channelID drugtxchannel -asOrg FeedexCorpMSP
echo "Configuaring anchor peer for CircleH drugtxchannel"
../bin/configtxgen -profile DrugTxChannel -outputAnchorPeersUpdate ./channel-artifacts/CircleHMSPanchors_drugtxchannel.tx -channelID drugtxchannel -asOrg CircleHMSP
echo "Configuaring anchor peer for AuthorityOrg drugtxchannel"
../bin/configtxgen -profile DrugTxChannel -outputAnchorPeersUpdate ./channel-artifacts/AuthorityOrgMSPanchors_drugtxchannel.tx -channelID drugtxchannel -asOrg AuthorityOrgMSP

echo "Configuaring anchor peer for ViePharmaCorp distributorargchannel"
../bin/configtxgen -profile DistributorArgChannel -outputAnchorPeersUpdate ./channel-artifacts/ViePharmaCorpMSPanchors_distributorargchannel.tx -channelID distributorargchannel -asOrg ViePharmaCorpMSP
echo "Configuaring anchor peer for FeedexCorp distributorargchannel"
../bin/configtxgen -profile DistributorArgChannel -outputAnchorPeersUpdate ./channel-artifacts/FeedexCorpMSPanchors_distributorargchannel.tx -channelID distributorargchannel -asOrg FeedexCorpMSP

echo "Configuaring anchor peer for FeedexCorp retailerargchannel"
../bin/configtxgen -profile RetailerArgChannel -outputAnchorPeersUpdate ./channel-artifacts/FeedexCorpMSPanchors_retailerargchannel.tx -channelID retailerargchannel -asOrg FeedexCorpMSP
echo "Configuaring anchor peer for CircleH retailerargchannel"
../bin/configtxgen -profile RetailerArgChannel -outputAnchorPeersUpdate ./channel-artifacts/CircleHMSPanchors_retailerargchannel.tx -channelID retailerargchannel -asOrg CircleHMSP


echo "Sleep 5s"
sleep 5

export VIEPHARMACORP_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/viepharmacorp.com/ca && ls *_sk)
export FEEDEXCORP_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/feedexcorp.com/ca && ls *_sk)
export CIRCLEH_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/circleh.com/ca && ls *_sk)
export AUDITOR_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/auditor.gov.com/ca && ls *_sk)

echo "Starting the network"
docker-compose -f docker-compose-cli.yaml -f docker-compose-etcdraft2.yaml -f docker-compose-couch.yaml -f docker-compose-ca.yaml up -d

export CONFIG_ROOT=/opt/gopath/src/github.com/hyperledger/fabric/peer
export VIEPHARMACORP_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/viepharmacorp.com/users/Admin@viepharmacorp.com/msp
export VIEPHARMACORP_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/viepharmacorp.com/peers/peer0.viepharmacorp.com/tls/ca.crt
export FEEDEXCORP_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/feedexcorp.com/users/Admin@feedexcorp.com/msp
export FEEDEXCORP_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/feedexcorp.com/peers/peer0.feedexcorp.com/tls/ca.crt
export CIRCLEH_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/circleh.com/users/Admin@circleh.com/msp
export CIRCLEH_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/circleh.com/peers/peer0.circleh.com/tls/ca.crt
export AUDITOR_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/auditor.gov.com/users/Admin@auditor.gov.com/msp
export AUDITOR_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/auditor.gov.com/peers/peer0.auditor.gov.com/tls/ca.crt
export ORDERER_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/ordererOrganizations/drugchain.com/orderers/orderer.drugchain.com/msp/tlscacerts/tlsca.drugchain.com-cert.pem

echo "Create channel drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel create \
    -o orderer.drugchain.com:7050 \
    -c drugtxchannel \
    -f ./channel-artifacts/drugtxchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Sleep 5s"
sleep 5 

echo "Create channel distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel create \
    -o orderer.drugchain.com:7050 \
    -c distributorargchannel \
    -f ./channel-artifacts/distributorargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Create channel retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel create \
    -o orderer.drugchain.com:7050 \
    -c retailerargchannel \
    -f ./channel-artifacts/retailerargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}