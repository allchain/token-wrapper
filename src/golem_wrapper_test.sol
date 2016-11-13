pragma solidity ^0.4.4;

import 'dapple/test.sol';

import "erc20/base.sol";
import "./golem_wrapper.sol";

contract GolemWrapperTest is Test {
    GolemAPI G;
    GolemWrapperAPI W;
    // TODO Override to use target from env/chain
    function getGolemToken() returns (GolemAPI) {
        return GolemAPI(address(new ERC20Base(100)));
    }
    function setUp() {
        G = getGolemToken();
        W = new GolemWrapper(G);
    }
    function testSetup() {
        assertTrue( G.balanceOf(this) == 100 );
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
    function testFailWrongUser() {
    }
}  
