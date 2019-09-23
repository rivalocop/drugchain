package main

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

//StorageChaincode definded
type StorageChaincode struct {
}

//Storage struct defined
type Storage struct {
	ObjectType        string `json:"docType"`
	ID                string `json:"id"`
	Name              string `json:"name"`
	ProductsAvailable int64  `json:"products_available"`
	ProductsShipped   int64  `json:"products_shipped"`
	ProductsRecieved  int64  `json:"products_recieved"`
}

//Init when StorageChaincode is instantiated
func (s *StorageChaincode) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

//Invoke command with CLI
func (s *StorageChaincode) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "initLedger" {
		return s.InitLedger(APIstub)
	} else if function == "sendProducts" {
		return s.SendProducts(APIstub, args)
	} else if function == "sentProducts" {
		return s.SentProducts(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract function name.")
}

//InitLedger for seeding data
func (s *StorageChaincode) InitLedger(APIstub shim.ChaincodeStubInterface) sc.Response {
	manusStorage := Storage{ObjectType: "storage", ID: "S01", Name: "FeedexCorpStorage", ProductsAvailable: 100, ProductsShipped: 0, ProductsRecieved: 0}
	dtbStorage := Storage{ObjectType: "storage", ID: "S02", Name: "CircleH", ProductsAvailable: 0, ProductsShipped: 0, ProductsRecieved: 0}

	manusStorageAsByte, _ := json.Marshal(manusStorage)
	dtbStorageAsByte, _ := json.Marshal(dtbStorage)

	APIstub.PutState(manusStorage.ID, manusStorageAsByte)
	APIstub.PutState(dtbStorage.ID, dtbStorageAsByte)
	return shim.Success(nil)
}

//SendProducts for sending products
//args[0] - fromId, args[1] - amount
func (s *StorageChaincode) SendProducts(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	amount, _ := strconv.ParseInt(args[1], 10, 64)
	fromStorage := Storage{}

	fromStorageAsByte, _ := APIstub.GetState(args[0])

	json.Unmarshal(fromStorageAsByte, &fromStorage)

	fromStorage.ProductsAvailable = fromStorage.ProductsAvailable - amount
	fromStorage.ProductsShipped = amount

	fromStorageAsByte, _ = json.Marshal(fromStorage)
	APIstub.PutState(fromStorage.ID, fromStorageAsByte)

	return shim.Success(nil)
}

//SentProducts for product had been sent
func (s *StorageChaincode) SentProducts(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	amount, _ := strconv.ParseInt(args[1], 10, 64)
	toStorage := Storage{}

	toStorageAsByte, _ := APIstub.GetState(args[0])

	json.Unmarshal(toStorageAsByte, &toStorage)

	toStorage.ProductsAvailable = toStorage.ProductsAvailable + amount
	toStorage.ProductsRecieved = amount

	toStorageAsByte, _ = json.Marshal(toStorage)
	APIstub.PutState(toStorage.ID, toStorageAsByte)

	return shim.Success(nil)
}

func main() {

	// Create a new Smart Contract
	err := shim.Start(new(StorageChaincode))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
