# Metacrafters-ETH-Proof-Intermediate-Module-1

This repository contains an example Solidity smart contract that demonstrates the usage of `require()`, `assert()`, and `revert()` statements. The contract provides basic functionalities such as depositing and withdrawing Ether, transferring ownership, and performing safe division.

## Contract Features
- **Owner Management**: Only the contract owner can transfer ownership.
- **Ether Management**: Users can deposit and withdraw Ether from the contract.
- **Error Handling**: Proper error handling using `require()`, `assert()`, and `revert()` statements.
- **Safe Division**: Demonstrates handling division by zero using `revert()`.

## Smart Contract Overview
### Functions
- `deposit()`: Allows users to deposit Ether into the contract.
- `withdraw(uint amount)`: Allows users to withdraw Ether from their balance.
- `transferOwnership(address newOwner)`: Allows the current owner to transfer ownership to a new address.
- `safeDivide(uint a, uint b)`: Safely divides two numbers, reverting if division by zero is attempted.
- `receive() external payable`: Fallback function to receive Ether.

### Modifiers
- `onlyOwner()`: Restricts access to certain functions to the contract owner.

### Statements Used
- **`require()`**: 
  - Ensures only the owner can call certain functions.
  - Ensures the deposit amount is greater than zero.
  - Ensures the user has sufficient balance before withdrawal.
  - Ensures the new owner is not the zero address.
- **`assert()`**:
  - Ensures the balance is correctly updated after withdrawal.
  - Ensures the owner is correctly updated after transferring ownership.
- **`revert()`**:
  - Handles division by zero in the `safeDivide` function.

## Deployment
To deploy this contract, you can use Remix, Truffle, or Hardhat. Below are the basic steps using Remix:

1. Open [Remix](https://remix.ethereum.org/).
2. Create a new file and paste the contract code.
3. Compile the contract.
4. Deploy the contract using the JavaScript VM or connect to an Ethereum testnet.
