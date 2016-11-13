WARNING: ALPHA TESTING - USE AT YOUR OWN RISK

This is a wrapper contract which lets you deposit GOLEM tokens into an ERC20-compatible wrapper, in the spirit of [weth] and [ds-eth-token]. This allows it to be used with existing dapps like Maker Market, EtherDelta, etc, as well future dapps like the maker core CDP engine used for creating DAI.

An interface to this wrapper will be available on the deposit/withdraw tab on [mkr.market](), next to the ETH token wrapper. Any other dapp can point to the same token wrapper contract, and could offer a similar UI.
