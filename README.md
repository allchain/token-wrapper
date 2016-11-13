WARNING: ALPHA TESTING - USE AT YOUR OWN RISK

About
--- 
This is a wrapper contract which lets you deposit GNT tokens into an ERC20-compatible wrapper, in the spirit of [weth] and [ds-eth-token]. This allows it to be used with existing dapps like Maker Market, EtherDelta, etc, as well future dapps like the maker core CDP engine used for creating DAI.

An interface to this wrapper will be available on the deposit/withdraw tab on [mkr.market](https://mkr.market), next to the ETH token wrapper. Any other dapp can point to the same token wrapper contract, and could offer a similar UI.

*A note on migration*: GNT is designed with arguably the worst upgrade strategy possible, which does not allow any dependent contracts to follow upgrades without manual intervention. Most token manipulation contracts are valuable *because* they have no "admin" backdoors. Because of this, we have opted to NOT include an "upgrade backdoor" for this wrapper, hoping that the Golem team will take the opportunity to create a future-proof token contract when they upgrade their token, which should also make a wrapper unnecessary if it implements ERC20. You will be able to `withdraw` and then follow the normal migration procedure at that time.

Usage:
---
```
var G = GolemAPI(0xTODO);  // the golem contract
var W = GolemWrapper(0xTODO);  // the wrapped token contract

// Deposits must be done via a "broker" due to lack of "pull" functionality on G
var broker = W.createBroker();  // A new broker just for you
var balance = G.balanceOf(this);
G.transfer(broker, balance); //  Only transfer to your own broker!
broker.clear();

assert(balance == W.balanceOf(this)); // Wow !
W.approve(mkr_market, balance); // Scandalous !

// I want out!
W.withdraw(balance);
assert(balance == G.balanceOf(this));
```


