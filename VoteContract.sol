// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DecentralizedVoting {
    address public owner;

    struct Poll {
        string question;
        string[] options;
        mapping(uint => uint) votes;
        mapping(address => bool) hasVoted;
        uint endTime;
        bool exists;
    }

    mapping(uint => Poll) public polls;
    uint public pollCount;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Modifier to check if the poll exists
    modifier pollExists(uint pollId) {
        require(polls[pollId].exists, "Poll does not exist");
        _;
    }

    // Modifier to check if the poll is active
    modifier pollActive(uint pollId) {
        require(block.timestamp < polls[pollId].endTime, "Poll has ended");
        _;
    }

    // Function to create a new poll
    function createPoll(string memory question, string[] memory options, uint duration) public onlyOwner {
        require(options.length > 1, "Poll must have at least two options");
        require(duration > 0, "Poll duration must be greater than zero");
        
        pollCount++;
        Poll storage newPoll = polls[pollCount];
        newPoll.question = question;
        newPoll.options = options;
        newPoll.endTime = block.timestamp + duration;
        newPoll.exists = true;

        // Ensure the poll was created correctly
        assert(newPoll.exists == true);
        assert(newPoll.endTime > block.timestamp);
    }

    // Function to vote in a poll
    function vote(uint pollId, uint option) public pollExists(pollId) pollActive(pollId) {
        Poll storage poll = polls[pollId];
        require(!poll.hasVoted[msg.sender], "You have already voted in this poll");
        require(option < poll.options.length, "Invalid option");
        
        poll.votes[option]++;
        poll.hasVoted[msg.sender] = true;

        // Ensure the vote was counted
        assert(poll.hasVoted[msg.sender] == true);
        assert(poll.votes[option] > 0);
    }

    // Function to get poll details
    function getPoll(uint pollId) public view pollExists(pollId) returns (string memory question, string[] memory options, uint endTime) {
        Poll storage poll = polls[pollId];
        return (poll.question, poll.options, poll.endTime);
    }

    // Function to get poll results
    function getResults(uint pollId) public view pollExists(pollId) returns (uint[] memory) {
        Poll storage poll = polls[pollId];
        require(block.timestamp > poll.endTime, "Poll is still active");
        
        uint[] memory results = new uint[](poll.options.length);
        for (uint i = 0; i < poll.options.length; i++) {
            results[i] = poll.votes[i];
        }
        return results;
    }

    // Function to withdraw poll creation if needed
    function withdrawPoll(uint pollId) public onlyOwner pollExists(pollId) {
        Poll storage poll = polls[pollId];
        require(block.timestamp < poll.endTime, "Cannot withdraw a poll that has ended");

        delete polls[pollId];

        // Ensure the poll was deleted
        assert(!polls[pollId].exists);
    }

    // Fallback function to prevent accidental ether transfers
    receive() external payable {
        revert("Direct transfers not allowed");
    }
}
