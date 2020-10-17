pragma solidity >=0.5.0;
import "./DappToken.sol";
contract DappTokenSale{

    address payable admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);
    event EndSale(uint256 _totalAmountSold);

    constructor (DappToken _tokenContract, uint256 _tokenPrice) public
    {
        //assign an admin
        admin = msg.sender;
        //tokrn contract
        tokenContract = _tokenContract;
        //set token price
        tokenPrice = _tokenPrice;

    }

    //multiply
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }


    //buying token
    function buyTokens(uint256 _numberOfTokens) public payable {
        //Require that value is equal to tokens
        require(msg.value == multiply(_numberOfTokens, tokenPrice));


        //reqiure that the contract has enough tokens
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);

        //reqiure a transaction is successful
        require(tokenContract.transfer(msg.sender, _numberOfTokens));


        //keep track of number of tokensSold
        tokensSold += _numberOfTokens;
        //emit a sell event
        emit Sell(msg.sender, _numberOfTokens);

    }

    //Ending the DappToken Sale 
    function endSale() public {

        //Enquire admin
        require(msg.sender == admin);
        //Transfer remaining DappTokens to the admin
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        //Destroy the contract
        admin.transfer(address(this).balance);

        emit EndSale(tokensSold);
    }
}
