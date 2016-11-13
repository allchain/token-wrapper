WARNING: ALPHA TESTING - USE AT YOUR OWN RISK

Usage:
```
var G = GolemAPI(0xTODO);  // the golem contract
var W = GolemWrapper(0xTODO);  // the wrapped token contract

// Deposits must be done via a "broker" due to lack of "pull" functionality on G
var broker = W.createBroker();  // A new broker just for you
G.transfer(broker, G.balanceOf(this)); //  Only transfer to your own broker!
broker.clear();

W.balanceOf(this); // Wow !
W.approve(mkr_market, 10**18); // Scandalous!

// I want out!
W.withdraw();
G.balanceOf(this);
```

This is a wrapper contract which lets you deposit GNT tokens into an ERC20-compatible wrapper, in the spirit of [weth] and [ds-eth-token]. This allows it to be used with existing dapps like Maker Market, EtherDelta, etc, as well future dapps like the maker core CDP engine used for creating DAI.

An interface to this wrapper will be available on the deposit/withdraw tab on [mkr.market](), next to the ETH token wrapper. Any other dapp can point to the same token wrapper contract, and could offer a similar UI.
