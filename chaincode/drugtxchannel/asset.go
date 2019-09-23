package main

/* Imports
 * 4 utility libraries for formatting, handling bytes, reading and writing JSON, and string manipulation
 * 2 specific Hyperledger Fabric specific libraries for Smart Contracts
 */
import (
	"bytes"
	"encoding/json"
	"fmt"
	"strconv"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Define the Smart Contract structure
type SmartContract struct {
}

// Define the car structure, with 4 properties.  Structure tags are used by encoding/json library
type Drug struct {
	Name          string  `json:"name"`
	Quantity      string  `json:"quantity"`
	UseCase       string  `json:"usecase"`
	Manufacturer  string  `json:"manufacturer"`
	DeliveryOwner string  `json:"delivery_owner"`
	Cost          float64 `json:"cost"`
	UpdatedDate   string  `json:"updated_date"`
}

/*
 * The Init method is called when the Smart Contract "fabcar" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see InitLedger()
 */
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "fabcar"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "QueryDrug" {
		return s.QueryDrug(APIstub, args)
	} else if function == "InitLedger" {
		return s.InitLedger(APIstub)
	} else if function == "CreateDrug" {
		return s.CreateDrug(APIstub, args)
	} else if function == "QueryAllDrugs" {
		return s.QueryAllDrugs(APIstub)
	}

	return shim.Error("Invalid Smart Contract function name.")
}

func (s *SmartContract) QueryDrug(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	drugAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(drugAsBytes)
}

func (s *SmartContract) InitLedger(APIstub shim.ChaincodeStubInterface) sc.Response {
	drugs := []Drug{
		Drug{Name: "Paracetamol", Cost: 6.5, Quantity: "10", UseCase: "Sick Burner", Manufacturer: "ViePharmaCorp", DeliveryOwner: "ViePharmaCorp"},
		Drug{Name: "Paracetamol2", Cost: 7, Quantity: "11", UseCase: "Sick Burner", Manufacturer: "ViePharmaCorp", DeliveryOwner: "ViePharmaCorp"},
		Drug{Name: "Paracetamol3", Cost: 7.5, Quantity: "12", UseCase: "Sick Burner", Manufacturer: "ViePharmaCorp", DeliveryOwner: "ViePharmaCorp"},
		Drug{Name: "Paracetamol4", Cost: 8, Quantity: "13", UseCase: "Sick Burner", Manufacturer: "ViePharmaCorp", DeliveryOwner: "ViePharmaCorp"},
	}

	i := 0
	for i < len(drugs) {
		fmt.Println("i is ", i)
		drugAsBytes, _ := json.Marshal(drugs[i])
		APIstub.PutState("DRUG"+strconv.Itoa(i), drugAsBytes)
		fmt.Println("Added", drugs[i])
		i = i + 1
	}

	return shim.Success(nil)
}

func (s *SmartContract) CreateDrug(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 5 {
		return shim.Error("Incorrect number of arguments. Expecting 5")
	}

	newCost, _ := strconv.ParseFloat(args[4], 64)

	var drug = Drug{
		Name:          args[1],
		Quantity:      args[2],
		UseCase:       args[3],
		Cost:          newCost,
		Manufacturer:  "ViePharmaCorp",
		DeliveryOwner: "ViePharmaCorp",
		UpdatedDate:   time.Now().Format("Mon Jan 2 15:04:05 -0700 MST 2006"),
	}

	drugAsBytes, _ := json.Marshal(drug)
	APIstub.PutState(args[0], drugAsBytes)

	return shim.Success(nil)
}

func (s *SmartContract) QueryAllDrugs(APIstub shim.ChaincodeStubInterface) sc.Response {

	startKey := "DRUG0"
	endKey := "DRUG999"

	resultsIterator, err := APIstub.GetStateByRange(startKey, endKey)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()

	// buffer is a JSON array containing QueryResults
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- QueryAllDrugs:\n%s\n", buffer.String())

	return shim.Success(buffer.Bytes())
}

func (s *SmartContract) changeDeliveryOwner(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 2 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	//Get by ID
	drugAsBytes, _ := APIstub.GetState(args[0])
	drug := Drug{}

	json.Unmarshal(drugAsBytes, &drug)
	drug.DeliveryOwner = args[1]
	drug.UpdatedDate = time.Now().Format("Mon Jan 2 15:04:05 -0700 MST 2006")
	APIstub.PutState(args[0], drugAsBytes)

	return shim.Success(nil)
}

// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
