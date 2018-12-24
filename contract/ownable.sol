// solium-disable linebreak-style
pragma solidity ^0.4.19;
/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;
    event Fail(string msg);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    function Ownable() public {
        owner = msg.sender;
    }


    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        // require(msg.sender == owner, "You are not the manager!");
        if(msg.sender == owner){
           _; 
        }
        else{
            emit Fail("You are not the manager!");
        }
    }


    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "You can't transfer to yourself!");
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

}
