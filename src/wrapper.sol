pragma solidity ^0.4.24;

import "ds-token/base.sol";

import "./interfaces.sol";

contract DepositBroker is DepositBrokerInterface {
    ReducedToken _g;
    TokenWrapper _w;
    constructor( ReducedToken token ) public {
        _w = TokenWrapper(msg.sender);
        _g = token;
    }
    function clear() public {
        uint256 amount = _g.balanceOf(this);
        _g.transfer(_w, amount);
        _w.notifyDeposit(amount);
    }
}

contract TokenWrapperEvents {
    event LogBroker(address indexed broker);
}

// Deposits only accepted via broker!
contract TokenWrapper is DSTokenBase(0), TokenWrapperInterface, TokenWrapperEvents {
    ReducedToken _unwrapped;
    mapping(address=>address) _broker2owner;
    mapping(address=>address) _owner2broker;
    
    constructor( ReducedToken unwrapped) public {
        _unwrapped = unwrapped;
    }
    
    function createBroker() public returns (DepositBrokerInterface) {
        DepositBroker broker;
        if( _owner2broker[msg.sender] == address(0) ) {
            broker = new DepositBroker(_unwrapped);
            _broker2owner[broker] = msg.sender;
            _owner2broker[msg.sender] = broker;
            emit LogBroker(broker);
        }
        else {
            broker = DepositBroker(_owner2broker[msg.sender]);
        }
        
        return broker;
    }
    function notifyDeposit(uint amount) public {
        address owner = _broker2owner[msg.sender];
        require(owner > address(0));
        _balances[owner] = add(_balances[owner], amount);
        _supply = add(_supply, amount);
    }
    function withdraw(uint amount) public {
        require(_balances[msg.sender] >= amount);
        _balances[msg.sender] = sub(_balances[msg.sender], amount);
        _supply = sub(_supply, amount);
        _unwrapped.transfer(msg.sender, amount);
    }
    function getBroker() public view returns (DepositBrokerInterface) {
        return DepositBroker(_owner2broker[msg.sender]);
    }
}
