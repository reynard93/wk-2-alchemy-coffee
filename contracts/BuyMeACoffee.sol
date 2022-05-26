//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
//Deployed to goerli at 0x59823ad5f14D49E00C7dd01E10A191902D92b11A
import "hardhat/console.sol";

contract BuyMeACoffee {
    // event to emit when a memo is created
    event NewMemo(
        address indexed from, // makes it easier to search for addresses
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // list of all memos from frens
    Memo[] memos;

    // address of contract dev
    address payable owner;

    // deploy logic
    constructor() {
        owner = payable(msg.sender); // find out who deployed this contract
    }

    // memory for after we are done with this func throw it away
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee without eth");
        // add memo to storage
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));
        // emit a log event when new memo is created
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

//    /**
//    * @dev send the entire balance stored in this contrac to the owner
//    */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

// view signals doesnt change anything on the blockchain
//this retrieves all the memos received and stored on the blockchain
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}
