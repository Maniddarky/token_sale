pragma solidity>=0.5.0;

contract DappToken{
    //name
    string public name = "DApp Token";
    //symbol
    string public symbol = "DAPP";
    //standard 
    string public standard = "DApp Token v1.0";
    uint256 public totalSupply;

    event Transfer(
       address indexed _from,
       address indexed _to,
       uint256 _value
    );
    //approve event

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256))  public allowance;

    //allowance

    constructor (uint256 _initialSupply) public {
        balanceOf[msg.sender]=_initialSupply;
        totalSupply = _initialSupply;
        //allocate the initialSupply
    }
    //transfer
    
    function transfer(address _to,uint256 _value) public returns (bool success){
        //Exception if account doesn't have enough
        require(balanceOf[msg.sender]>= _value);

        balanceOf[msg.sender]-=_value;
        balanceOf[_to]+=_value;

        //Transfer event
        emit Transfer(msg.sender,_to,_value);
        //return boolean
        return true;   
    }
    
    //approve
    function approve(address _spender,uint256 _value) public returns (bool success) {
        //allowance
        allowance[msg.sender][_spender]=_value;
        //approve event
        emit Approval(msg.sender,_spender,_value);
        return true;

    }

    //tranfer from 
    function transferFrom(address _from ,address _to, uint256 _value) public returns (bool success){

        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        //Require _from has enough tokens
        //Require the allowance is big enough
        //Change the balance
        balanceOf[_from]-= _value;
        balanceOf[_to]+= _value;
        //update the allowance
        allowance[_from][msg.sender]-=_value;
        //Transfer event
        emit Transfer(_from, _to, _value);
        //return true
        return true;


    }

}
