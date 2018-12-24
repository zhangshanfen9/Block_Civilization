// solium-disable linebreak-style
pragma solidity ^0.4.19;
import "./civilization_expand.sol";

contract civilization_functions is civilization_expand {
    //氪金费用
    uint popuUpFee = 0.0001 ether;

    //新建城市或者状态修改的事件
    event NewCity(uint civiId, string name, uint economy, uint politics, uint military, string message);
    event CityStatus(uint civiId, string name, uint economy, uint politics, uint military, string message);

    //保证人口到达一定值
    modifier abovePopulation(uint _popu, uint _cityId) {
        // require(cities[_cityId].popu >= _popu, "The level of the city is too low!");
        if(cities[_cityId].popu >= _popu){
            _;
        }
        else{
            emit Fail("The level of the city is too low!");
        }
    }

    //合约部署者收割玩家的充值
    function reap() external onlyOwner {
        owner.transfer(this.balance);
        emit Success("Reaped successfully!");
    }

    //合约部署者设定氪金的价格
    function setPopuUpFee(uint _fee) external onlyOwner {
        popuUpFee = _fee;
        emit Success("Set successfully!");
    }

    //玩家接口：用来氪金使城市快速升级
    function quickLevelUp(uint _cityId) external payable {
        // require(msg.value == popuUpFee, "money is too much or too little!");
        if(msg.value >= popuUpFee){
            growCity(_cityId, 10);
            emit Success("Level up successfully!");
        }
        else{
            emit Fail("money is too little!");
        }
    }

    //玩家接口：用来改变城市名字
    function changeName(uint _cityId, string _newName) external abovePopulation(2, _cityId) onlyOwnerOf(_cityId) {
        cities[_cityId].name = _newName;
        emit Success("");
    }

    //玩家接口，用来合并城市
    function mergeCity(uint to_id, uint from_id) external abovePopulation(10, to_id) onlyOwnerOf(from_id) {
        City storage from_city = cities[from_id];
        City storage to_city = cities[to_id];
        uint temprate = (from_city.econ + from_city.poli + from_city.muli) / 5;
        growCity(to_id, temprate);
        to_city.popu = to_city.popu + from_city.popu / 4;
        from_city.popu /= 2;
        from_city.econ /= 2;
        from_city.poli /= 2;
        from_city.muli /= 2;
        _triggerCooldown(from_city);
        _triggerCooldown(to_city);
        emit Success("");
    }

    //玩家接口，用来得到某个所有者的所有城市ID
    function getcitiesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerCityCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < cities.length; i++) {
            if (cityToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

}
