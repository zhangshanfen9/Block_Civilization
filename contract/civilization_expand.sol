// solium-disable linebreak-style
pragma solidity ^0.4.19;

import "./civilization_creator.sol";

//用来和world合约交互，为了方便调试暂时注释
// contract worldInterface {
//     function getWorld() external view returns (
//         uint difficulty,
//         string worldType
//         );
// }

contract civilization_expand is civilization_creator {

    // worldInterface worldContract;

    //保证调用者是城市拥有着的修饰器
    modifier onlyOwnerOf(uint id) {
        // require(msg.sender == cityToOwner[id], "You are not the owner of the city!");
        if(msg.sender == cityToOwner[id]){
            _;
        }
        else{
            emit Fail("You are not the owner of the city!");
        }
    }

    // function setWorldContractAddress(address _address) external onlyOwner {
    //     worldContract = worldInterface(_address);
    // }

    //触发城市冷却
    function _triggerCooldown(City storage _city) internal {
        uint tempcool;
        if(cooldownTime / 10 < _city.econ){
            tempcool = cooldownTime / 10;
        }
        else{
            tempcool = cooldownTime - _city.econ;
        }
        _city.readyTime = uint32(now + tempcool);
    }

    //检查城市是否冷却完毕
    function _isReady(City storage _city) internal view returns (bool) {
        return (_city.readyTime <= now);
    }

    //扩张
    function _expansion(uint Id, uint difficulty, string newName) internal onlyOwnerOf(Id) {
        City storage city = cities[Id];
        bool ready = _isReady(city);
        if(ready == false){
            emit Fail("The city need cool down!");
        }
        // require(_isReady(city), "The city need cool down!");
        else{
            if(city.poli > uint(difficulty / 2)){
                forceCreateRandomCity(newName);
            }
            uint rate;
            if(city.poli < difficulty){
                rate = 1 + (100 - difficulty + city.poli) / 10;
            }
            else{
                rate = 8;
            }
            growCity(Id, rate);
            _triggerCooldown(city);
        }
    }
    
    // event Expansion(string msg);
    
    //玩家接口，用来扩张城市
    function expansion(uint Id, string newName) public {
        uint difficulty;
        // (difficulty, ) = worldContract.getWorld();
        (difficulty, ) = getWorld();
        _expansion(Id, difficulty, newName);
        emit Success("");
    }
    
    //临时函数，用来方便调试
    function getWorld() internal view returns(uint, string){
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
}
