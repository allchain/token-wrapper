pragma solidity ^0.4.4;

import 'ds-token/base.sol';

contract ReducedToken {
    function balanceOf(address _owner) returns (uint256);
    function transfer(address _to, uint256 _value) returns (bool);
    function migrate(uint256 _value);
}

contract DepositBrokerInterface {
    function clear();
}

contract TokenWrapperInterface is ERC20 {
    function withdraw(uint amount);

    // NO deposit, must be done via broker! Sorry!
    function createBroker() returns (DepositBrokerInterface);

    // broker contracts only - transfer to a personal broker then use `clear`
    function notifyDeposit(uint amount);

    function getBroker(address owner) returns (DepositBrokerInterface);
}


