// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract VoteToken is ERC20, ERC20Permit {
    constructor(address recipient)
        ERC20("VoteToken", "VT")
        ERC20Permit("VoteToken")
    {
        _mint(recipient, 1000 * 10 ** decimals());
    }
}

contract VoteFactory {
    address public owner;

    Event ContractCreate(address indexed addressContract, string description, uint durationTime);

    Vote[] public votes;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }

    function createVote(string calldata desc, uint duration) external onlyOwner{
        Vote newVote = new Vote(desc, duration);
        votes.push(newVote);

        emit ContractCreate(address(newVote), desc, duration);
    }

}

contract Vote {
    address public parent;
    string public desc;
    uint immutable endsAt;

    mapping (address => uint) public voteResults;
    mapping (address => bool) public isVoted;

    address[] public voters;
    
    // кто проголосовал
    // за или против

    constructor(string memory _desc, uint _duration) {
        parent = msg.sender;
        desc = _desc;
        endsAt = block.timestamp + _duration;
    }

    function 

}
