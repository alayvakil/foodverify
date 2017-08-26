pragma solidity ^0.4.4;

contract ProvenFood {
  
  struct food {
    address origin;
    uint amount;
    uint weight;
    uint date;
    string name;
    uint historyLength;
    mapping (uint => historyObject) history;
  }


  struct historyObject {
    address holder;
    uint timeStamp;
  }

  mapping (string => food) foods;

  function newFood(uint _weight, uint _amount, string _name, string _uniqueID){
    
    foods[_uniqueID] = food(msg.sender, _amount, _weight, now, _name, 0);
    
    historyObject memory newObj;
    newObj.holder = msg.sender;
    newObj.timeStamp = now;

    foods[_uniqueID].history[foods[_uniqueID].historyLength] = newObj;
    foods[_uniqueID].historyLength++;
  }

  function getOrigin(string _uniqueID) constant returns (address){
    return foods[_uniqueID].origin;
  }

  function getAmount(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].amount;
  }

  function getWeight(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].weight;
  }

  function getDate(string _uniqueID) constant returns (uint){
    return foods[_uniqueID].date;
  }

  function getName(string _uniqueID) constant returns (string){
    return foods[_uniqueID].name;
  }

  function getHistory(string _uniqueID) constant returns (address, uint){
    //uint size = foods[_uniqueID].historyLength;
    //address[] memory _history = new address[](size);
    
    //for (uint i = 0; i < foods[_uniqueID].historyLength; i++) { 
    //  _history[i] = foods[_uniqueID].history[i];
    //}
    return (foods[_uniqueID].history[0].holder,foods[_uniqueID].history[0].timeStamp);
  }

  /* function moveFood(string _uniqueID, address _to){
    uint historyIndex = foods[_uniqueID].historyLength - 1;
    if(msg.sender == foods[_uniqueID].history[historyIndex]){
      foods[_uniqueID].history[historyIndex + 1] = _to;
      foods[_uniqueID].historyLength++;
    }
  } */
}
`