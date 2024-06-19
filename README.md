# Metacrafters-ETH-Proof-Intermediate-Module-1

# Decentralized Voting Smart Contract

## Overview
The `DecentralizedVoting` smart contract is a decentralized and transparent voting system on the Ethereum blockchain. It allows users to create polls, vote on options, and view results. This contract ensures fair voting processes with secure and verifiable results.

## Features
- **Poll Creation**: Only the contract owner can create polls with specified questions, options, and duration.
- **Voting**: Any user can vote on a poll during its active period. Each user can vote only once per poll.
- **Poll Details**: Anyone can view the question, options, and end time of any poll.
- **Poll Results**: The results of the poll can be viewed by anyone once the poll ends.
- **Poll Withdrawal**: The contract owner can withdraw a poll before it ends.

## Error Handling
The contract uses `require()`, `assert()`, and `revert()` statements to enforce rules and handle errors:
- `require()` ensures conditions are met before proceeding with execution.
- `assert()` checks for conditions that should always be true, verifying the internal state.
- `revert()` handles conditions that fail and stops execution.

## Functions

### Constructor
```solidity
constructor()
```
- Sets the deployer as the owner of the contract.

### Modifiers
```solidity
modifier onlyOwner()
```
- Restricts access to the owner.

```solidity
modifier pollExists(uint pollId)
```
- Ensures the poll exists.

```solidity
modifier pollActive(uint pollId)
```
- Ensures the poll is active.

### Create Poll
```solidity
function createPoll(string memory question, string[] memory options, uint duration) public onlyOwner
```
- Creates a new poll with a question, options, and duration.
- Requires at least two options and a duration greater than zero.
- Uses `assert()` to verify poll creation.

### Vote
```solidity
function vote(uint pollId, uint option) public pollExists(pollId) pollActive(pollId)
```
- Allows a user to vote on a poll.
- Requires the user hasn't already voted and the option is valid.
- Uses `assert()` to verify vote recording.

### Get Poll Details
```solidity
function getPoll(uint pollId) public view pollExists(pollId) returns (string memory question, string[] memory options, uint endTime)
```
- Returns the question, options, and end time of a poll.

### Get Results
```solidity
function getResults(uint pollId) public view pollExists(pollId) returns (uint[] memory)
```
- Returns the results of a poll.
- Requires the poll to have ended.

### Withdraw Poll
```solidity
function withdrawPoll(uint pollId) public onlyOwner pollExists(pollId)
```
- Allows the owner to withdraw an active poll.
- Requires the poll hasn't ended.
- Uses `assert()` to verify poll deletion.

### Fallback Function
```solidity
receive() external payable
```
- Prevents accidental Ether transfers using `revert()`.

## Usage

### Deploying the Contract
1. Deploy the contract on the Ethereum network using a compatible Ethereum development environment (e.g., Remix, Hardhat).
2. The deployer will be set as the owner of the contract.

### Creating a Poll
1. Call `createPoll(string memory question, string[] memory options, uint duration)` as the owner.
2. Provide the question, options, and duration in seconds.

### Voting
1. Call `vote(uint pollId, uint option)` to vote on an active poll.
2. Ensure you haven't voted on the poll before and the option is valid.

### Viewing Poll Details
1. Call `getPoll(uint pollId)` to view the question, options, and end time of a poll.

### Viewing Results
1. Call `getResults(uint pollId)` to view the results of a poll after it has ended.

### Withdrawing a Poll
1. Call `withdrawPoll(uint pollId)` as the owner to withdraw an active poll before it ends.

## Example
```solidity
// Deploy the contract
DecentralizedVoting voting = new DecentralizedVoting();

// Owner creates a poll
voting.createPoll("What is your favorite color?", ["Red", "Blue", "Green"], 3600);

// User votes on a poll
voting.vote(1, 2); // Votes for "Green" in poll ID 1

// View poll details
(string memory question, string[] memory options, uint endTime) = voting.getPoll(1);

// View poll results after it ends
uint[] memory results = voting.getResults(1);
```

## License
This project is licensed under the MIT License.
