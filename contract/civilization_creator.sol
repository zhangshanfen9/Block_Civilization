// solium-disable linebreak-style
pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract civilization_creator is Ownable {

    using SafeMath for uint256;
    //事件：新建城市或城市状态改变，便于调试和后期在前端实现效果
    // event NewCity(uint civiId, string name, uint economy, uint politics, uint military, string message);
    // event CityStatus(uint civiId, string name, uint economy, uint politics, uint military, string message);
    event Success(string msg);
    event Fail(string msg);
    event StatusChange(string msg);
    event NewCity(uint index, string msg);
    event GrowCity(uint index, string msg);
    event WeakenCity(uint index, string msg);

    //DEBUG
    uint cooldownTime = 10 seconds;
    //REAL
    //uint cooldownTime = 3 hours;

    //城市的几个属性：名字、冷却时间、人口、经济、政治、军事
    struct City {
        string name;
        uint readyTime;
        uint popu;
        uint econ;
        uint poli;
        uint muli;
    }

    //用来储存所有的城市
    City[] internal cities;

    //用来储存城市所有者和所有者城市数量
    mapping (uint => address) internal cityToOwner;
    mapping (address => uint) internal ownerCityCount;

    //创建城市
    function _createCity(string _name, uint _econ, uint _poli, uint _muli) internal returns (uint) {
        uint id = cities.push(City(_name, uint(now + cooldownTime), 1, _econ, _poli, _muli)) - 1;
        cityToOwner[id] = msg.sender;
        ownerCityCount[msg.sender]++;
        return id;
    }

    //生成随机数
    function _generateRandomNum(uint moldulus, uint salt) internal view returns (uint) {
        uint rand = uint(keccak256(now, msg.sender, salt));
        return rand % moldulus;
    }

    //玩家接口，用来生成第一座城市
    function createRandomCity(string _name) public {
        // require(ownerCityCount[msg.sender] == 0, "The player has one or more cities!");
        if(ownerCityCount[msg.sender] == 0){
            uint _econ = 1 + _generateRandomNum(3, 1);
            uint _poli = 1 + _generateRandomNum(3, 2);
            uint _muli = 1 + _generateRandomNum(3, 3);
            uint id = _createCity(_name, _econ,  _poli, _muli);
            emit Success("You create a city successfully!");
        }
        else{
            emit Fail("The player has one or more cities!");
        }
    }

    //生成一座城市
    function forceCreateRandomCity(string _name) internal {
        uint _econ = 1 + _generateRandomNum(3, 1);
        uint _poli = 1 + _generateRandomNum(3, 2);
        uint _muli = 1 + _generateRandomNum(3, 3);
        uint id = _createCity(_name, _econ,  _poli, _muli);
        // NewCity(id, _name, _econ, _poli, _muli, "You build a new city!");
        emit StatusChange("Status changed!");
        emit NewCity(id, "You get a new city!");
    }

    //城市发展
    function growCity(uint Id, uint rate) internal {
        City storage city = cities[Id];
        city.econ = city.econ + rate + _generateRandomNum(2, 0);
        city.poli = city.poli + rate + _generateRandomNum(2, 1);
        city.muli = city.muli + rate + _generateRandomNum(2, 2);
        //设置上限
        if(city.econ >= 100){
            city.econ = 100;
        }
        if(city.poli >= 100){
            city.poli = 100;
        }
        if(city.muli >= 100){
            city.muli = 100;
        }
        city.popu += 1;
        //事件通知
        // CityStatus(Id, city.name, city.econ, city.poli, city.muli, "The city has developed!");
        emit StatusChange("Status changed!");
        emit GrowCity(Id, "A city growed!");
    }
    //城市削弱
    function destoryCity(uint Id, uint rate) internal {
        City storage city = cities[Id];
        city.econ = city.econ - rate + _generateRandomNum(7, 0);
        city.poli = city.poli - rate + _generateRandomNum(7, 1);
        city.muli = city.muli - rate + _generateRandomNum(7, 2);
        city.popu -= 1;
        //设置下限
        if(city.econ > 100){
            city.econ = 1;
        }
        if(city.poli > 100){
            city.poli = 1;
        }
        if(city.muli > 100){
            city.muli = 1;
        }
        if(city.popu > 100){
            city.popu = 1;
        }
        // CityStatus(Id, city.name, city.econ, city.poli, city.muli, "The city has been weakened!");
        emit StatusChange("Status changed!");
        emit WeakenCity(Id, "A city weaken!");
        
    }

    function getCityDetails(uint Id) public view returns(address, string, uint, uint, uint, uint, uint){
        return (cityToOwner[Id], cities[Id].name, cities[Id].popu, cities[Id].poli, cities[Id].econ, cities[Id].muli, cities[Id].readyTime);
    }
    
    function getCitiesNum() public view returns(uint){
        return cities.length;
    }
    
    function test() public pure returns(string){
        return "hello!";
    }
}
