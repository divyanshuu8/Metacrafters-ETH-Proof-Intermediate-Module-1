# Metacrafters-ETH-Proof-Intermediate-Module-1

This repository contains a simple banking smart contract written in Solidity. The contract demonstrates the use of `require()`, `assert()`, and `revert()` statements for error handling and ensuring the integrity of the contract's state. The contract includes functionalities for depositing funds, withdrawing funds, and transferring ownership.

## Features

- **Owner Management**: Only the contract owner can transfer ownership.
- **Ether Management**: Users can deposit and withdraw Ether from the contract.
- **Error Handling**: Proper error handling using `require()`, `assert()`, and `revert()` statements.

## Smart Contract Overview

### Functions

- `deposit()`: Allows users to deposit Ether into the bank.
- `withdraw(uint amount)`: Allows users to withdraw Ether from their balance.
- `transferOwnership(address newOwner)`: Allows the current owner to transfer ownership to a new address.
- `safeWithdraw(uint amount)`: Safely withdraws Ether, reverting if the user has insufficient balance.
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
  - Handles cases where a user attempts to withdraw more than their balance.

## Deployment and Interaction Instructions

To deploy and interact with this contract using Remix, follow these steps:

1. **Open Remix:**
   Open [Remix](https://remix.ethereum.org/) in your web browser.

2. **Create a New File:**
   - Click on the "File Explorers" tab on the left sidebar (first icon from the top).
   - Click the "New File" button.
   - Name the new file `SimpleBank.sol`.
   - Paste the smart contract code into this file.
