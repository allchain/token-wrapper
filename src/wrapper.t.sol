pragma solidity ^0.4.4;

import 'ds-test/test.sol';

import "ds-token/base.sol";
import "./wrapper.sol";

contract WrapperTest is DSTest {
    ReducedToken G; // G for GNT
    TokenWrapperInterface W;
    // TODO Override to use target from env/chain
    function getToken() returns (ReducedToken) {
        return ReducedToken(address(new DSTokenBase(100)));
    }
    function setUp() {
        G = getToken();
        W = new TokenWrapper(G);
    }
    function testSetup() {
        assert(G.balanceOf(this) == 100);
    }
    function testTheBasics() {
        var broker = W.createBroker();
        G.transfer(broker, 100);
        broker.clear();
        assertEq(100, W.balanceOf(this));

        W.transfer(0xb0b, 50);
        assertEq(50, W.balanceOf(this));

        W.withdraw(45);
        assertEq(5, W.balanceOf(this));
        assertEq(45, G.balanceOf(this));
    }
    function testSingletonBroker() {
        var broker = W.createBroker();
        var broker2 = W.createBroker();
        assertEq(broker2, broker);
    }
    function testUserHasBroker() {
        var broker = W.createBroker();
        assertEq(W.getBroker(this), broker);
    }
}  
