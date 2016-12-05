// From: https://gist.github.com/mhhf/803df998215871f65dc4ec7ee4ac21d2

// transfer.ds.sol
pragma solidity ^0.4.4;

import "dapple/script.sol";
import "dapple/test.sol";
import "../golem_source.sol";

contract SetupTokenBalances is Script {
  function SetupTokenBalances() {

    // Set up an Actor
    var actor = new Tester();
    actor._target(env.gnt);
    exportObject("actor", actor);

    txoff();
    // this should be treated as a static call
    uint balance = env.gnt.balanceOf(tx.origin);
    txon();

    // give the actor some balance
    env.gnt.transfer(actor, balance);
  }
}
