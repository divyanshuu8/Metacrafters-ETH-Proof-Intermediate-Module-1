// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleBank {
    address public owner;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Function to deposit ether into the bank
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
    }

    // Function to withdraw ether from the bank
    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(balances[msg.sender] >= 0); // Sanity check
    }

    // Function to transfer ownership of the bank
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
        assert(owner == newOwner); // Ensure the owner is correctly updated
    }

    // Function to demonstrate revert() usage
    function safeWithdraw(uint amount) public {
        if (amount > balances[msg.sender]) {
            revert("Insufficient balance for withdrawal");
        }
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Fallback function to receive ether
    receive() external payable {
        deposit();
    }
}
