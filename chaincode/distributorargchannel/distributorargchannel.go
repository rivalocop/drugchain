package main

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

//CostArgChaincode struct defined
type CostArgChaincode struct {
}

//Drug struct defined
type Drug struct {
	ID            string  `json:"id"`
	Name          string  `json:"name"`
	Quantity      string  `json:"quantity"`
	UseCase       string  `json:"usecase"`
	Manufacturer  string  `json:"manufacturer"`
	DeliveryOwner string  `json:"delivery_owner"`
	Cost          float64 `json:"cost"`
	UpdatedDate   string  `json:"updated_date"`
}

//CostArg struct defined
type CostArg struct {
	ObjectType string  `json:"docType"`
	DrugID     string  `json:"id"`
	ArgCost    float64 `json:"agreement_cost"`
	Discount   float64 `json:"agreement_discount"`
}

//Init when CostArgChaincode is isntatiated
func (s *CostArgChaincode) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

//Invoke command with CLI
func (s *CostArgChaincode) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "initLedger" {
		return s.InitLedger(APIstub)
	} else if function == "newArg" {
		return s.NewArg(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract function name.")
}

//InitLedger for seeding data
func (s *CostArgChaincode) InitLedger(APIstub shim.ChaincodeStubInterface) sc.Response {
	f := "QueryDrug"
	cnname := "drugtxchannel"
	ccname := "drugcc"
	drugIns := GetDrug(APIstub, ccname, "DRUG1", cnname, f)
	argCost := MappingDrugArg(drugIns, 0.2)

	s.SaveArg(APIstub, "DRUG1", argCost)
	return shim.Success(nil)
}

//NewArg : Create an new agreement for a product
//args[0] - id of product, args[1] - discount
func (s *CostArgChaincode) NewArg(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	f := "QueryDrug"
	cnname := "drugtxchannel"
	ccname := "drugcc"

	discount, _ := strconv.ParseFloat(args[1], 64)
	drugIns := GetDrug(APIstub, ccname, args[0], cnname, f)
	argCost := MappingDrugArg(drugIns, discount)

	s.SaveArg(APIstub, args[0], argCost)

	return shim.Success(nil)
}

//SaveArg for saving a new arg to worldstate
func (s *CostArgChaincode) SaveArg(APIstub shim.ChaincodeStubInterface, drugID string, argCost CostArg) {
	argCostAsByte, _ := json.Marshal(argCost)
	err := APIstub.PutState(drugID, argCostAsByte)

	if err != nil {
		fmt.Println(err)
	}
}

//GetDrug for get a drug from drug worldstate
func GetDrug(APIstub shim.ChaincodeStubInterface, ccname string, drugID string, cnname string, fname string) Drug {
	drugIns := Drug{}

	invokeArgs := MakeInvokeChainCodeArgs(fname, drugID)
	response := APIstub.InvokeChaincode(ccname, invokeArgs, cnname)

	err := json.Unmarshal(response.Payload, &drugIns)
	if err != nil {
		fmt.Println(err)
	}

	return drugIns
}

// MakeInvokeChainCodeArgs converts string args to []byte args
func MakeInvokeChainCodeArgs(args ...string) [][]byte {
	bargs := make([][]byte, len(args))
	for i, arg := range args {
		bargs[i] = []byte(arg)
	}
	return bargs
}

//MappingDrugArg for mapping attribute from drug instance to argcost instantce
func MappingDrugArg(drugIns Drug, discount float64) CostArg {
	argCost := CostArg{}

	argCost.ObjectType = "agreement"
	argCost.DrugID = drugIns.ID
	argCost.Discount = discount
	argCost.ArgCost = drugIns.Cost * (1 - argCost.Discount)

	return argCost
}

func main() {
	// Create a new Smart Contract
	err := shim.Start(new(CostArgChaincode))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
