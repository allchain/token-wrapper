pragma solidity ^0.4.4;

import 'erc20/base.sol';

import './interfaces.sol';

contract GolemDepositBroker is GolemDepositBrokerAPI {
    GolemAPI _g;
    GolemWrapperAPI _w;
    address public _client;
    function GolemDepositBroker( GolemAPI golem, address client ) {
        _w = GolemWrapperAPI(msg.sender);
        _g = golem;
        _client = client;
    }
    function clear() {
        if( msg.sender != _client )
            throw;
        var amount = _g.balanceOf(this);
        _g.transfer(_w, amount);
        _w.notifyDeposit(_client, amount);
    }
}

// Deposits only accepted via broker!
contract GolemWrapper is ERC20Base(0), GolemWrapperAPI {
    GolemAPI _unwrapped;
    mapping(address=>address) _broker2owner;
    function GolemWrapper( GolemAPI unwrapped) {
        _unwrapped = unwrapped;
    }
    function createBroker() returns (GolemDepositBrokerAPI) {
        var broker = new GolemDepositBroker(_unwrapped, msg.sender);
        _broker2owner[broker] = msg.sender;
        return broker;
    }
    function notifyDeposit(address client, uint amount) {
        if( _broker2owner[msg.sender] != client ) {
            throw;
        }
        var owner = _broker2owner[msg.sender];
        if( client != owner ) {
            throw;
        }
        _balances[client] += amount;
    }
    function withdraw(uint amount) {
        if( _balances[this] < amount ) {
            throw;
        }
    }
    function migrate() {
        _unwrapped.migrate(_unwrapped.balanceOf(this));
    }
}
