pragma solidity ^0.4.24;

import "ds-token/base.sol";

contract ReducedToken {
    function balanceOf(address _owner) public view returns (uint256);
    function transfer(address _to, uint256 _value) public returns (bool);
    function migrate(uint256 _value) public;
}

contract DepositBrokerInterface {
    function clear() public;
}

contract TokenWrapperInterface is ERC20 {
    function withdraw(uint amount) public;

    // NO deposit, must be done via broker! Sorry!
    function createBroker() public returns (DepositBrokerInterface);

    // broker contracts only - transfer to a personal broker then use `clear`
    function notifyDeposit(uint amount) public;

    function getBroker() public view returns (DepositBrokerInterface);
}


