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
        require(msg.value >= minimumContribution, "Minimum contribution is not met");

        // if it is first contribution from sender then increase number Of Contributors
        if (contributors[msg.sender] == 0){
            numberOfContributors += 1;
        }

        // increase contributors value and raised amt
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    // get contract balance
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public {
        // check deadline has passed and target is not reached 

        // check that sender has made some contributions

        // if all conditions met make the sender payable

        // proceed with transfer whatever contribution that were made

        // after refund make contribution of sender => 0 
    }

}
