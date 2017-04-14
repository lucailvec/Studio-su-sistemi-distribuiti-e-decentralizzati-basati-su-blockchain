pragma solidity ^0.4.10;


library Lib{
    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
        bytes storage a = bytes(_a);
        bytes memory b = bytes(_b);
        if (a.length != b.length)
            return false;
        for (uint i = 0; i < a.length; i ++)
            if (a[i] != b[i])
                return false;
        return true;
    }
}
contract Address2Name {
    struct Personal{
        mapping (uint => string ) book;
        uint last;
    }
    modifier validId(uint _n){
        if(ledger[msg.sender].last<=_n) throw;
        _;
    }
    mapping (address => Personal ) public ledger;
    
    function addName2Book(string _name) internal returns (uint _id){
        uint l = ledger[msg.sender].last;
        ledger[msg.sender].book[l]=_name;
        l+=1;
        ledger[msg.sender].last=l;
        return l;
    }
    
    function getNameByOwner(address _addr,uint _n) external constant returns (string nome) {
        return ledger[_addr].book[_n];
    }
    
    function changeNameById(string _name,uint _n)internal 
    validId(_n){//lo sovrascrivo se mi invento un uint troppo alto
        ledger[msg.sender].book[_n]=_name;
    }
    
    function getLast() constant internal returns (uint last) {
        ledger[msg.sender].last;
    }
}

contract Name2Address{
    
    mapping (bytes32 => N2AEntry) public hashMap;
    
    struct N2AEntry{
        address owner;
        address contr;
    }
    function addContract(string _name,address _contr) internal returns (bytes32 sha){
        bytes32 _sha = sha256(_name);
        hashMap[_sha].owner = msg.sender;
        hashMap[_sha].contr = _contr;
        return _sha;
    }
    
    function changeByName(string _str, address _contr) internal {
       bytes32 _sha = sha256(_str);
       if(hashMap[_sha].owner != msg.sender)throw;
        hashMap[_sha].contr = _contr;
    }
    
}

contract GlobalRegistrar is Name2Address,Address2Name{
    
    using Lib for string;
    event EventNewContract(string name,address _address,address _owner);
    event EventChanged(string from,string to,address contrAddress,address _owner);
    
    function add(string _name,address _contr){
        bytes32 _sha= addContract(_name,_contr);
        //addName2Book(_name);
        EventNewContract(_name,_contr,msg.sender);
    }
    /*
    function change(string _newName, address _contr,string _pastName){
        bool find=false;
        uint x = 0;
        for(var i=0; i< getLast(); i++ ){
            if((ledger[msg.sender].book[x]).stringsEqual(_pastName)){
                find=true;
                x=i;
                changeByName( _newName,  _contr);
                changeNameById(_newName,x);
                EventChanged(_newName,_pastName,_contr,msg.sender);
                break;
            }
        }

    }*/
    function getAddressContract(string _str) constant external returns(address addressContract){
        bytes32 _sha= sha256(_str);
        return hashMap[_sha].contr;
    }
    function getOwnerOfContract(string _str) constant external returns(address addressOwner){
        bytes32 _sha= sha256(_str);
        return hashMap[_sha].owner;    
    }
    
}