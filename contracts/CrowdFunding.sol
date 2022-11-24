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
    uint public amount;

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
        // check min value
        // if no contribution frm sender increase the no of contro
        // increase contributors value and raised amt
    }
}
