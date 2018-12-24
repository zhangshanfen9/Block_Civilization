// solium-disable linebreak-style
pragma solidity ^0.4.19;

import "./civilization_functions.sol";

contract civilization is civilization_functions {
    //事件：占领、胜利、失败
    // event Occupy(uint civiId, string message);
    // event WinMessage(string message);
    // event LoseMessage(string message);

    //玩家接口，攻击城市
    function Invade(uint my_id, uint target_Id) external onlyOwnerOf(my_id) {
        City storage myCity = cities[my_id];
        City storage ememy_city = cities[target_Id];
        uint rand = _generateRandomNum(125, 0);
        uint rate = 100;
        uint econ_gap;
        if(myCity.muli < ememy_city.muli){
            rate = 100 - (ememy_city.muli - myCity.muli);
        }
        if(myCity.econ > ememy_city.econ){
            econ_gap = 0;
        }
        else{
            econ_gap = ememy_city.econ - myCity.econ;
        }
        //攻击成功
        if (rand <= rate) {
            // WinMessage("You win the war!");
            growCity(my_id, econ_gap + 5);
            destoryCity(target_Id, econ_gap + 5);
            //REAL
            if(rand <= 5){
            //DEBUG
            // if(rand <= 1000){
                //占领城市
                ownerCityCount[cityToOwner[target_Id]]--;
                cityToOwner[target_Id] = msg.sender;
                ownerCityCount[msg.sender]++;
                _triggerCooldown(ememy_city);
                // Occupy(target_Id, "You occupy an ememy's city!");
            }
        } else {
            //攻击失败
            // LoseMessage("You lose the war!");
            destoryCity(my_id, econ_gap + 5);
        }
        //触发冷却
        _triggerCooldown(myCity);
        emit Success("");
    }
}
