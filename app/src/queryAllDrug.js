const fabric_client = require("fabric-client");
const path = require("path");
const util = require("util");
const os = require("util");

const client = new fabric_client();

const newChannel = client.newChannel("drugtxchannel");
const peer = client.newPeer("grpc://localhost:7051");

const member_user = null;
const store_path = path.join(os.homedir(), ".hfc-key-store");
console.log("Store path:" + store_path);
const tx_id = null;

fabric_client
  .newDefaultKeyValueStore({
    path: store_path
  })
  .then(state_store => {
    client.setStateStore(state_store);
    let crypto_suite = fabric_client.newCryptoSuite();
    let crypto_store = fabric_client.newCryptoKeyStore({ path: store_path });
    crypto_suite.setCryptoKeyStore(crypto_store);
    client.setCryptoSuite(crypto_suite);

    return client.getUserContext("user1", true);
  })
  .then(user_from_store => {
    if (user_from_store && user_from_store.isEnrolled) {
      console.log("Success enrolled user");
      member_user = user_from_store;
    } else {
      throw new Error("Failed to get user1.... run registerUser.js");
    }
  });
