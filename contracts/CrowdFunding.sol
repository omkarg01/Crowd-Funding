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
    modifier onlyManager(){
        require(msg.sender == manager,"Only manager are allowed to call this function.");
        _;
    }


    // create a function called creatRequest which takes desc, recipient, value and allow onlyManager
    function createRequest(string memory _description, address payable _recipient, uint _value) public onlyManager {
        // create a newRequest
        Request storage newRequest = requests[numRequests];
        numRequests += 1;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.noOfVoters = 0;
        newRequest.completed = false;
    }

    // create a voteRequest function which takes a num to vote 
    function voteRequest(uint _requestNo) public{
        // check user has made some contributions
        require(contributors[msg.sender] > 0, "You need to be contributor to vote");

        // get request which user has requested for
        Request storage thisRequest = requests[_requestNo];

        // check user has already voted for this request
        require(thisRequest.voters[msg.sender] == false, "You have already voted");

        // make true for the thisRequest 
        thisRequest.voters[msg.sender] = true;

        // increment the noOfVoters
        thisRequest.noOfVoters += 1;
    }

    // make payment to particular request allow only to manager
    function makePayment(uint _requestNo) public onlyManager{
        // check if raised amount is greater than or equal to target
        require(raisedAmount >= target, "Target is not reached");

        // if yes get the request 
        Request storage thisRequest = requests[_requestNo];

        // check if request has completed
        require(thisRequest.completed == false);

        // check if majority supports this request
        require(thisRequest.noOfVoters > numberOfContributors/2, "Majority is not supporting this request");

        // if yes transfer the value to recipient
        thisRequest.recipient.transfer(thisRequest.value);

        // after payment make request as complete
        thisRequest.completed = true;
    } 

}
