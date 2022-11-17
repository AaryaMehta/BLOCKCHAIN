// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.4;
//MyCoin is the friendly name for the contract definition.
// It is only used to reference this contract in code by other contracts.
// Remember that contracts are invoked by knowing the public address, 
//so it is impossible to have a collision by name.
contract MyCoin {
    //mapping is a particular construct in Solidity that acts as a Dictionary 
    //or Hash for key/value pairs. The main difference with a regular Hash is that
    // you can not enumerate keys or values. Address and Uint are specific data types 
    //that represent a public address and an unsigned integer, respectively.
    // Balances is a private variable (stored in storage) that maintains the balance 
    //in tokens for a given address.
    mapping (address => uint) balances;
//Transfer is an event emitted by the contract whose payload 
//contains two addresses (from/to) and a value. Since contracts 
//run asynchronously once a Validator mines them, they don't return any response.
// A way to emulate responses is to emit events. Those are recorded in a transaction
// log that any Node connected in the network can query. Also, client libraries usually
// provide a way to attach to those events.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
 //The contract constructor is invoked just once when it is initially deployed in 
 //the Blockchain,
 // and a public address is assigned. It assigns an arbitrary number of tokens 
 //to the address that originated the deployment (or, in other words, to the contract owner).
 // "tx" is an implicit variable that gives access to information about the current
 // transaction in context.   
    constructor()  {
        balances[tx.origin] = 10000;
    }
    //This method moves tokens from one address (the owner) to another address (the receiver
    // address). 
    //As it would happen with "tx", "msg" is another variable that provides access to the 
    //execution context. This implementation uses the msg variable to infer the sender of 
    //the transaction. It checks if the sender has available tokens in the balance and then
    // moves it to the receiver address. If no balance is available, it returns false, 
    //and the transaction gets completed. Finally, it emits the "Transfer" event and
    // returns true to finalize the transaction.
    function sendCoin(address receiver, uint amount) public returns(bool success) {
        if (balances[msg.sender] < amount) return false;

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;    }
//getBalance returns the balance in tokens associated with an address. The keyword "view" 
//expresses that this method does 
//not make any change and only pulls data from the ledger. The node executing this method
// can just query the ledger without submitting any transaction, so Gas is not required.
    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }
}