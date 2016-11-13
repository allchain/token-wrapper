pragma solidity ^0.4.4;

import 'erc20/erc20.sol';

contract GolemAPI {
    function balanceOf(address _owner) returns (uint256);
    function transfer(address _to, uint256 _value) returns (bool);
    function migrate(uint256 _value);
}

contract GolemDepositBrokerAPI {
    function clear();
}

contract GolemWrapperAPI is ERC20 {
    function withdraw(uint amount);

    // NO deposit, must be done via broker! Sorry!
    function createBroker() returns (GolemDepositBrokerAPI);

    // broker contracts only - transfer to a personal broker then use `clear`
    function notifyDeposit(address client, uint amount);
}


