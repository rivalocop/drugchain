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


echo "Init ledger function drugtx"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"InitLedger","Args":[]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --peerAddresses peer0.circleh.com:11051 \
    --peerAddresses peer0.auditor.gov.com:13051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${CIRCLEH_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${AUDITOR_TLS_ROOTCERT_FILE}

echo "Init ledger function distributorarg"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C distributorargchannel -n distributorcc -c '{"function":"initLedger","Args":[]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE}

echo "Init ledger function retailerarg"
docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C retailerargchannel -n retailercc -c '{"function":"initLedger","Args":[]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.circleh.com:11051 \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --tlsRootCertFiles ${CIRCLEH_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE}

  