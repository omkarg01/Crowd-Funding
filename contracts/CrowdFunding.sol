// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CrowdFunding {
    // declare all require variables
    // constributors map
    mapping(address => uint) public contributors;

    // manager address
    address public manager;

    // min contro
    uint public minimumContribution;

    // deadline
    uint public deadline;

    // target
    uint public target;

    // raised amt
    uint public raisedAmount;

    // no of contros
    uint public numberOfContributors;

    struct Request {
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address => bool) voters;
    }

    mapping(uint => Request) public requests;
    uint public numRequests;

    // a constructors which sets the targets, deadline, min contro, manager
    constructor(uint _target, uint _deadline) {
        target = _target;
        deadline = block.timestamp + _deadline;
        minimumContribution = 100 wei;
        manager = msg.sender;
    }

    // send eth function
    function sendEth() public payable {
        // check deadline
        require(block.timestamp < deadline, "Deadline has passed");

        // check min value
        require(
            msg.value >= minimumContribution,
            "Minimum contribution is not met"
        );

        // if it is first contribution from sender then increase number Of Contributors
        if (contributors[msg.sender] == 0) {
            numberOfContributors += 1;
        }

        // increase contributors value and raised amt
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    // get contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function refund() public {
        // check deadline has passed and target is not reached
        require(block.timestamp > deadline && raisedAmount < target, "You are not eligible");

        // check that sender has made some contributions
        require(contributors[msg.sender] > 0);

        // if all conditions met make the sender payable
        address payable user = payable(msg.sender);

        // proceed with transfer whatever contribution that were made
        user.transfer(contributors[msg.sender]);

        // after refund make contribution of sender => 0
        contributors[msg.sender] = 0;
    }

    // allow only manager (using modifier)


    // create a function called creatRequest which takes desc, recipient, value and allow onlyManager
    {
        // create a newRequest
    }

    // create a voteRequest function which takes a num to vote 
    {
        // check user has made some contributions

        // get request which user has requested for

        // check user has already voted for this request

        // make true for the thisRequest 

        // increment the noOfVoters
    }

}
