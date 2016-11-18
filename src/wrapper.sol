pragma solidity ^0.4.4;

import 'erc20/base.sol';

import './interfaces.sol';

contract DepositBroker is DepositBrokerInterface {
    ReducedToken _g;
    TokenWrapperInterface _w;
    function DepositBroker( ReducedToken token ) {
        _w = TokenWrapperInterface(msg.sender);
        _g = token;
    }
    function clear() {
        var amount = _g.balanceOf(this);
        _g.transfer(_w, amount);
        _w.notifyDeposit(amount);
    }
}

// Deposits only accepted via broker!
contract TokenWrapper is ERC20Base(0), TokenWrapperInterface {
    ReducedToken _unwrapped;
    mapping(address=>address) _broker2owner;
    function TokenWrapper( ReducedToken unwrapped) {
        _unwrapped = unwrapped;
    }
    function createBroker() returns (DepositBrokerInterface) {
        var broker = new DepositBroker(_unwrapped);
        _broker2owner[broker] = msg.sender;
        return broker;
    }
    function notifyDeposit(uint amount) {
        var owner = _broker2owner[msg.sender];
        if( owner == address(0) ) {
            throw;
        }
        _balances[owner] += amount;
        _supply += amount;
    }
    function withdraw(uint amount) {
        if( _balances[msg.sender] < amount ) {
            throw;
        }
        _balances[msg.sender] -= amount;
        _supply -= amount;
        _unwrapped.transfer(msg.sender, amount);
    }
}
