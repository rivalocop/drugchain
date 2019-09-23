CONFIG_ROOT=/opt/gopath/src/github.com/hyperledger/fabric/peer
VIEPHARMACORP_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/viepharmacorp.com/users/Admin@viepharmacorp.com/msp
VIEPHARMACORP_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/viepharmacorp.com/peers/peer0.viepharmacorp.com/tls/ca.crt
FEEDEXCORP_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/feedexcorp.com/users/Admin@feedexcorp.com/msp
FEEDEXCORP_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/feedexcorp.com/peers/peer0.feedexcorp.com/tls/ca.crt
CIRCLEH_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/circleh.com/users/Admin@circleh.com/msp
CIRCLEH_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/circleh.com/peers/peer0.circleh.com/tls/ca.crt
AUDITOR_MSPCONFIGPATH=${CONFIG_ROOT}/crypto/peerOrganizations/auditor.gov.com/users/Admin@auditor.gov.com/msp
AUDITOR_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/peerOrganizations/auditor.gov.com/peers/peer0.auditor.gov.com/tls/ca.crt
ORDERER_TLS_ROOTCERT_FILE=${CONFIG_ROOT}/crypto/ordererOrganizations/drugchain.com/orderers/orderer.drugchain.com/msp/tlscacerts/tlsca.drugchain.com-cert.pem
DRUGTX_CHAINCODE_PATH=github.com/chaincode/drugtxchannel/
DISTRIBUTOR_CHAINCODE_PATH=github.com/chaincode/distributorargchannel/
RETAILER_CHAINCODE_PATH=github.com/chaincode/retailerargchannel/

echo "Joining peer0.viepharmacorp.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer1.viepharmacorp.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer1.viepharmacorp.com:8051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viepharmacorp.com/peers/peer1.viepharmacorp.com/tls/ca.crt \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer0.viepharmacorp.com to distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b distributorargchannel.block

echo "Joining peer1.viepharmacorp.com to distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer1.viepharmacorp.com:8051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viepharmacorp.com/peers/peer1.viepharmacorp.com/tls/ca.crt \
  cli \
  peer channel join \
    -b distributorargchannel.block

echo "Joining peer0.feedexcorp.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer1.feedexcorp.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer1.feedexcorp.com:10051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/feedexcorp.com/peers/peer1.feedexcorp.com/tls/ca.crt \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer0.feedexcorp.com to distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b distributorargchannel.block

echo "Joining peer1.feedexcorp.com to distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer1.feedexcorp.com:10051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/feedexcorp.com/peers/peer1.feedexcorp.com/tls/ca.crt \
  cli \
  peer channel join \
    -b distributorargchannel.block

echo "Joining peer0.feedexcorp.com to retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b retailerargchannel.block

echo "Joining peer1.feedexcorp.com to retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer1.feedexcorp.com:10051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/feedexcorp.com/peers/peer1.feedexcorp.com/tls/ca.crt \
  cli \
  peer channel join \
    -b retailerargchannel.block

echo "Joining peer0.circleh.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:11051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer1.circleh.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer1.circleh.com:12051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/circleh.com/peers/peer1.circleh.com/tls/ca.crt \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer0.circleh.com to retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:11051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b retailerargchannel.block

echo "Joining peer1.circleh.com to retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer1.circleh.com:12051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/circleh.com/peers/peer1.circleh.com/tls/ca.crt \
  cli \
  peer channel join \
    -b retailerargchannel.block

echo "Joining peer0.auditor.gov.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=AuthorityOrgMSP \
  -e CORE_PEER_ADDRESS=peer0.auditor.gov.com:13051 \
  -e CORE_PEER_MSPCONFIGPATH=${AUDITOR_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${AUDITOR_TLS_ROOTCERT_FILE} \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Joining peer1.auditor.gov.com to drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=AuthorityOrgMSP \
  -e CORE_PEER_ADDRESS=peer1.auditor.gov.com:14051 \
  -e CORE_PEER_MSPCONFIGPATH=${AUDITOR_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/auditor.gov.com/peers/peer1.auditor.gov.com/tls/ca.crt \
  cli \
  peer channel join \
    -b drugtxchannel.block

echo "Update drugtxchannel anchor peer for ViePharmaCorp"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c drugtxchannel \
    -f ./channel-artifacts/ViePharmaCorpMSPanchors_drugtxchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update distributorargchannel anchor peer for ViePharmaCorp"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c distributorargchannel \
    -f ./channel-artifacts/ViePharmaCorpMSPanchors_distributorargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update drugtxchannel anchor peer for FeedexCorp"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c drugtxchannel \
    -f ./channel-artifacts/FeedexCorpMSPanchors_drugtxchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update distributorargchannel anchor peer for FeedexCorp"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c distributorargchannel \
    -f ./channel-artifacts/FeedexCorpMSPanchors_distributorargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update retailerargchannel anchor peer for FeedexCorp"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c retailerargchannel \
    -f ./channel-artifacts/FeedexCorpMSPanchors_retailerargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update drugtxchannel anchor peer for CircleH"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:13051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c drugtxchannel \
    -f ./channel-artifacts/CircleHMSPanchors_drugtxchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update retailerargchannel anchor peer for CircleH"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:13051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c retailerargchannel \
    -f ./channel-artifacts/CircleHMSPanchors_retailerargchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Update drugtxchannel anchor peer for AuthorityOrg"
docker exec \
  -e CORE_PEER_LOCALMSPID=AuthorityOrgMSP \
  -e CORE_PEER_ADDRESS=peer0.auditor.gov.com:13051 \
  -e CORE_PEER_MSPCONFIGPATH=${AUDITOR_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${AUDITOR_TLS_ROOTCERT_FILE} \
  cli \
  peer channel update \
    -o orderer.drugchain.com:7050 \
    -c drugtxchannel \
    -f ./channel-artifacts/AuthorityOrgMSPanchors_drugtxchannel.tx \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Installing drugtx smartcontract on peer0.viepharmacorp.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n drugcc \
    -v 1.0 \
    -p "${DRUGTX_CHAINCODE_PATH}"

echo "Installing drugtx smartcontract on peer0.feedexcorp.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n drugcc \
    -v 1.0 \
    -p "${DRUGTX_CHAINCODE_PATH}"

echo "Installing distributor smartcontract on peer0.viepharmacorp.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n distributorcc \
    -v 1.0 \
    -p "${DISTRIBUTOR_CHAINCODE_PATH}"

echo "Installing distributor smartcontract on peer0.feedexcorp.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n distributorcc \
    -v 1.0 \
    -p "${DISTRIBUTOR_CHAINCODE_PATH}"

echo "Installing smartcontract on peer0.circleh.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:11051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n drugcc \
    -v 1.0 \
    -p "${DRUGTX_CHAINCODE_PATH}"

echo "Installing smartcontract on peer0.auditor.gov.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=AuthorityOrgMSP \
  -e CORE_PEER_ADDRESS=peer0.auditor.gov.com:13051 \
  -e CORE_PEER_MSPCONFIGPATH=${AUDITOR_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${AUDITOR_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n drugcc \
    -v 1.0 \
    -p "${DRUGTX_CHAINCODE_PATH}"

echo "Installing retailerargchannel smartcontract on peer0.feedex.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n retailercc \
    -v 1.0 \
    -p "${RETAILER_CHAINCODE_PATH}"

echo "Installing retailerargchannel smartcontract on peer0.circleh.com"
docker exec \
  -e CORE_PEER_LOCALMSPID=CircleHMSP \
  -e CORE_PEER_ADDRESS=peer0.circleh.com:11051 \
  -e CORE_PEER_MSPCONFIGPATH=${CIRCLEH_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${CIRCLEH_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode install \
    -n retailercc \
    -v 1.0 \
    -p "${RETAILER_CHAINCODE_PATH}"

echo "Instantiating smart contract on drugtxchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode instantiate \
    -o orderer.drugchain.com:7050 \
    -C drugtxchannel \
    -n drugcc \
    -v 1.0 \
    -c '{"Args":[]}' \
    -P "AND('ViePharmaCorpMSP.peer','FeedexCorpMSP.peer','CircleHMSP.peer','AuthorityOrgMSP.peer')" \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Instantiating smart contract on distributorargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode instantiate \
    -o orderer.drugchain.com:7050 \
    -C distributorargchannel \
    -n distributorcc \
    -v 1.0 \
    -c '{"Args":[]}' \
    -P "AND('ViePharmaCorpMSP.peer','FeedexCorpMSP.peer')" \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}

echo "Instantiating smart contract on retailerargchannel"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
  peer chaincode instantiate \
    -o orderer.drugchain.com:7050 \
    -C retailerargchannel \
    -n retailercc \
    -v 1.0 \
    -c '{"Args":[]}' \
    -P "AND('CircleHMSP.peer','FeedexCorpMSP.peer')" \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE}