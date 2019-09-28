echo "Create drug"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"createDrug","Args":["keycode","name","quantity","usecase","cost"]}' \
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
    --peerAddresses peer0.feedexcorp.com:9051 \
    --peerAddresses peer0.circleh.com:11051 \
    --peerAddresses peer0.auditor.gov.com:13051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${CIRCLEH_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${AUDITOR_TLS_ROOTCERT_FILE} 

echo "queryDrug"
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"QueryDrug","Args":["DRUG1"]}' \
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
  
docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C distributorargchannel -n distributorcc -c '{"function":"newArg","Args":["DRUG2","0.3"]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.viepharmacorp.com:7051 \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --tlsRootCertFiles ${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE}

docker exec \
  -e CORE_PEER_LOCALMSPID=FeedexCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.feedexcorp.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=${FEEDEXCORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${FEEDEXCORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C retailerargchannel -n retailercc -c '{"function":"newArg","Args":["DRUG2","0.3"]}' \
    --tls \
    --cafile ${ORDERER_TLS_ROOTCERT_FILE} \
    --peerAddresses peer0.circleh.com:11051 \
    --peerAddresses peer0.feedexcorp.com:9051 \
    --tlsRootCertFiles ${CIRCLEH_TLS_ROOTCERT_FILE} \
    --tlsRootCertFiles ${FEEDEXCORP_TLS_ROOTCERT_FILE}

docker exec \
  -e CORE_PEER_LOCALMSPID=ViePharmaCorpMSP \
  -e CORE_PEER_ADDRESS=peer0.viepharmacorp.com:7051 \
  -e CORE_PEER_MSPCONFIGPATH=${VIEPHARMACORP_MSPCONFIGPATH} \
  -e CORE_PEER_TLS_ROOTCERT_FILE=${VIEPHARMACORP_TLS_ROOTCERT_FILE} \
  cli \
    peer chaincode invoke -o orderer.drugchain.com:7050 -C drugtxchannel -n drugcc -c '{"function":"ChangeOwner","Args":["DRUG2","FeedexCorp"]}' \
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