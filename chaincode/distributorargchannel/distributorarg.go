package main

import (
	"encoding/binary"
	"encoding/json"
	"fmt"
	"math"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

type distributorArg struct {
}

type balance struct {
	UniqueNumber string    `json:"id"`
	Balance      float64   `json:"balance"`
	UpdatedDate  time.Time `json:"updated_date"`
}

type order struct {
	Discount float64 `json:"discount"`
	Total    float64 `json:"total_cost"`
}

func float64frombytes(bytes []byte) float64 {
	bits := binary.LittleEndian.Uint64(bytes)
	float := math.Float64frombits(bits)
	return float
}

/*
 * The Init method is called when the Smart Contract "fabcar" is instantiated by the blockchain network
 * Best practice is to have any Ledger initialization in separate function -- see initLedger()
 */
func (s *distributorArg) Init(stub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

/*
 * The Invoke method is called as a result of an application request to run the Smart Contract "fabcar"
 * The calling application program has also specified the particular smart contract function to be called, with arguments
 */
func (s *distributorArg) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "seeBalance" {
		return s.checkBalance(APIstub, args[0])
	} else if function == "initBalance" {
		return s.initBalance(APIstub)
	} else if function == "payFirst" {
		return s.payFirst(APIstub, args)
	}
	return shim.Error("Invalid Smart Contract function name.")
}

func (s *distributorArg) checkBalance(APIstub shim.ChaincodeStubInterface, balanceOwner string) sc.Response {
	balanceAsBytes, _ := APIstub.GetState(balanceOwner)
	return shim.Success(balanceAsBytes)
}

func (s *distributorArg) initBalance(APIstub shim.ChaincodeStubInterface) sc.Response {
	feedexBalance := balance{UniqueNumber: "9007733586", Balance: 9999999}
	viepharmaBalance := balance{UniqueNumber: "5819654223", Balance: 9999999}
	feedexBalanceAsBytes, _ := json.Marshal(feedexBalance)
	viepharmaBalanceAsByte, _ := json.Marshal(viepharmaBalance)
	APIstub.PutState("feedexCorpBalance", feedexBalanceAsBytes)
	APIstub.PutState("viepharmaCorpBalance", viepharmaBalanceAsByte)

	return shim.Success(nil)
}

//input: args[0] - ownerId, args[1] - order, args[2]
//output: new balance
func (s *distributorArg) payFirst(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	data := order{}

	err := json.Unmarshal([]byte(args[2]), &data)

	if err != nil {
		fmt.Println(err)
	}

	s.updateBalance(APIstub, args[0], data.Discount, data.Total)

	return shim.Success(nil)
}

func (s *distributorArg) getCurrentBalance(APIstub shim.ChaincodeStubInterface, ownerID string) float64 {
	balanceAsBytes, _ := APIstub.GetState(ownerID)
	currentbalance := balance{}

	json.Unmarshal(balanceAsBytes, &currentbalance)
	return currentbalance.Balance
}

func (s *distributorArg) updateBalance(APIstub shim.ChaincodeStubInterface, ownerID string, discount float64, minus float64) balance {
	//args[0]: key
	//args[1]: minus balance
	balanceAsBytes, err := APIstub.GetState(ownerID)
	currentbalance := balance{}
	if err != nil {
		fmt.Println(err)
	}

	json.Unmarshal(balanceAsBytes, &currentbalance)
	newBalance := currentbalance.Balance - minus*discount

	currentbalance.Balance = newBalance
	currentbalance.UpdatedDate = time.Now()

	APIstub.PutState(ownerID, balanceAsBytes)

	return currentbalance
}

// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(distributorArg))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
