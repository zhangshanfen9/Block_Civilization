// solium-disable linebreak-style
pragma solidity ^0.4.18;

import "./ownable.sol";

contract world is Ownable{
    function getWorld() public view returns(uint, string){
        uint difficulty = _generateRandomNum(100, 0);
        string memory worldType;
        if(difficulty < 20){
            worldType = "平原";
        }
        else if(difficulty < 40){
            worldType = "丘陵";
        }
        else if(difficulty < 60){
            worldType = "草原";
        }
        else if(difficulty < 70){
            worldType = "森林";
        }
        else if(difficulty < 80){
            worldType = "冻土";
        }
        else{
            worldType = "沙漠";
        }
        return (difficulty, worldType);

    }
    function _generateRandomNum(uint moldulus, uint salt) private view returns (uint) {
        uint rand = uint(keccak256(now, msg.sender, salt));
        return rand % moldulus;
    }
}