echo "Create drug"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"createDrug","Args":["DRUG12","test","test","test"]}' \
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

echo "queryAllDrug"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"queryAllDrugs","Args":[]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE}

echo "queryDrug"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"queryDrug","Args":["Paracetamol"]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE}

echo "checkBalance"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C distributorargchannel -n distributorcc -c '{"function":"checkBalance","Args":["feedexCorpbalance"]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE}

docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C distributorargchannel -n distributorcc -c '{"function":"checkBalance","Args":["feedexCorpbalance"]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE}

docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C distributorargchannel -n distributorcc -c `{"function":"payFirst","Args":["feedexCorpbalance",`{"discount":0.2,"total":100}`]}` \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE}