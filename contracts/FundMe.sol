pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 954109 WITH CONSTANT VARIABLE AND WITH OUT 976569
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
       
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Does not meet min req");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    

     function withdraw() public onlyOwner {

         for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
         }
         // reseting arry
         funders = new address[] (0);

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");

    }

    modifier onlyOwner {
    //  require(msg.sender == i_owner, "sender is not owner!");
     if(msg.sender != i_owner) { revert NotOwner(); }
     _;
    }
}