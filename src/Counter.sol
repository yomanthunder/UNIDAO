// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 private storedBlockNumber;
    uint256 public lastBlockCalled;
    uint256 public payableAmount;
    // uint256 public blockStoreAfterCall;
    uint256 public latestBlockCalled;
    bool public myBool = true;
    address public payAddress;

    constructor() payable {
        storedBlockNumber = block.number;
        // input of address where you want the ether to be transfered after your death 
        payAddress = msg.sender;
        payableAmount = msg.value;
    }
    function setLatestBlockCalled(uint256 _latestBlockCalled ) public {
        
        latestBlockCalled = _latestBlockCalled;
    }
    // function to store ethereum in the contract
    function storeEthereum(uint256 _recievedAmount) public payable {
       payableAmount = payableAmount + _recievedAmount;
    }
    // transfer some amount of stored ethereum
    function transferEthereum(uint256 _transferAmount ) public payable {
        payable(payAddress).transfer(_transferAmount);
    }

    function checkAllive() public returns (bool) {
        setLatestBlockCalled(block.number);

        if (lastBlockCalled==0){
            if (latestBlockCalled>storedBlockNumber && latestBlockCalled<(block.number+10)) {
                lastBlockCalled = latestBlockCalled;
                return true;
            } else {
                return false;
            }
        }

        if (latestBlockCalled>lastBlockCalled && latestBlockCalled<(lastBlockCalled+10)) {
            lastBlockCalled = latestBlockCalled;
            return true;
        } else {
            return false;
        }
    }
    function stillAlive() public {
        myBool = checkAllive();

        if (myBool ==  false && payAddress != address(0)) {
            transferEthereum(payableAmount);
        }
    }
}
