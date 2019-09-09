package main

import (
	"encoding/binary"
	"encoding/json"
	"fmt"
	"math"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Define the Smart Contract structure
type DistributorArg struct {
}

// Define the car structure, with 4 properties.  Structure tags are used by encoding/json library
type Balance struct {
	UniqueNumber string  `json:"id"`
	Balance      float64 `json:"balance"`
	UpdatedDate  string  `json:"updated_date"`
}

type Order struct {
	Cost     float64 `json:"cost"`
	Discount float64 `json:"discount"`
	Total    float64 `json:"total_cost"`
}

type OrderDetails struct {
	DrugID   string  `json:"drug_id"`
	Quantity float64 `json:"quantity"`
	Cost     float64 `json:"cost"`
}

const discount = 0.2

func Float64frombytes(bytes []byte) float64 {
	bits := binary.LittleEndian.Uint64(bytes)
	float := math.Float64frombits(bits)
	return float
}

/*
 * The Init method is called when the Smart Contract "fabcar" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see initLedger()
 */
func (s *DistributorArg) Init(stub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "fabcar"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *DistributorArg) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "seeBalance" {
		return s.checkBalance(APIstub, args[0])
	} else if function == "initBalance" {
		return s.initBalance(APIstub)
	}
	return shim.Error("Invalid Smart Contract function name.")
}

func (s *DistributorArg) checkBalance(APIstub shim.ChaincodeStubInterface, balanceOwner string) sc.Response {
	balanceAsBytes, _ := APIstub.GetState(balanceOwner)
	return shim.Success(balanceAsBytes)
}

func (s *DistributorArg) initBalance(APIstub shim.ChaincodeStubInterface) sc.Response {
	feedexBalance := Balance{UniqueNumber: "9007733586", Balance: 9999999}
	viepharmaBalance := Balance{UniqueNumber: "5819654223", Balance: 9999999}
	feedexBalanceAsBytes, _ := json.Marshal(feedexBalance)
	viepharmaBalanceAsByte, _ := json.Marshal(viepharmaBalance)
	APIstub.PutState("feedexCorpBalance", feedexBalanceAsBytes)
	APIstub.PutState("viepharmaCorpBalance", viepharmaBalanceAsByte)

	return shim.Success(nil)
}

// func (s *DistributorArg) buyDrug(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
// 	//pay 30% money then wait the confirm
// 	//pay 30%
// 	//input: list of order detail
// 	//Get orderdetails
// 	var orderdetails = GetOrderDetails(args)
// 	//Calculate pay total
// 	//get current balance
// 	balanceAsBytes, _ := APIstub.GetState("feedexCorpBalance")
// 	currentBalance := float64(balanceAsBytes.balance)
// 	//get total pay
// 	var total float64
// 	total = 0
// 	for i := 0; i < len(orderdetails); i++ {
// 		total += orderdetails[i].Cost * orderdetails[i].Quantity
// 	}
// 	//new balance with 20%
// 	newBalance := currentBalance - total*0.3

// 	return shim.Success(nil)

// }

// func (s *DistributorArg) confirmBuyDrug(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
// 	//if all the orders has deliveried, confirm the order
// 	//pay 70% money then change the owner
// 	//pay 70%
// 	//input current balance, 70% money of total

// 	//output new balance
// }

// func GetOrderDetails(args []string) []OrderDetails {
// 	var data = make([]OrderDetails, len(args))

// 	for i := 0; i < len(args); i++ {
// 		err := json.Unmarshal([]byte(args[i]), &data[i])
// 		if err != nil {
// 			fmt.Print(err)
// 		}
// 	}
// 	return data
// }

// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(DistributorArg))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
