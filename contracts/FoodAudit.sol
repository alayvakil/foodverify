pragma solidity ^0.4.4;

contract FoodAudit {

    struct Entry {

        string name;
        uint EntryId;
        uint TimeStamp;
        uint LastEntryId;

    }

    mapping(uint => Entry) History;
    uint8 Count = 0;

    function NewEntry(string Name , uint EntryId){

        Entry memory newEntry;
        newEntry.name = Name;
        newEntry.EntryId = EntryId;
        newEntry.TimeStamp = now;

        if ( Count != 0 ){
            newEntry.LastEntryId = History[Count].EntryId;
        }

        History[Count] = newEntry;
        Count = Count + 1;

    }

    function getEntry(uint8 EntryNum) returns (string,uint,uint,uint){

        return (History[EntryNum].name,History[EntryNum].EntryId,History[EntryNum].LastEntryId,History[EntryNum].TimeStamp);

    }

    function getCount() returns (uint8) {

        return Count;
    }

}